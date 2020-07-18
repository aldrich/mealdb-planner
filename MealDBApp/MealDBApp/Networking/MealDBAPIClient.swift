//
//  MealDBAPIClient.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

typealias VoidCompletion = () -> Void

typealias IngredientsCompletion = ([Ingredient]) -> Void
typealias MealCompletion = (Meal?) -> Void
typealias MealsCompletion = ([Meal]) -> Void

protocol APIClient {
	
	func getIngredients(completion: @escaping IngredientsCompletion)
	
	func getMealById(_ id: Int, completion: @escaping MealCompletion)
	
	func getMealsByIngredient(_ ingredient: String, completion: @escaping MealsCompletion)
}

class MealDBAPIClient: APIClient {
	
	var session: URLSessionProtocol
	
	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}
	
	enum APIError: Error {
		case message(_ reason: String)
	}
	
	enum RequestConstants {
		
		static let baseURL = "https://www.themealdb.com/api/json/v1/1"
		
		static let getIngredients = "/list.php?i=list"
		
		static let getMealByIngredient = { (ingredient: String) in
			String(format: "/filter.php?i=%@", ingredient)
		}
		
		static let getMealById = { (id: Int) in
			String(format: "/lookup.php?i=%d", id)
		}
			
		// -- get meal thumbnail image
		// https://www.themealdb.com/images/media/meals/st1ifa1583267248.jpg/preview
		
		// -- get ingredient thumbnail image
		// https://www.themealdb.com/images/ingredients/sausages-small.png
	}
	
	enum MealDBRequest {
		
		case getIngredients
		case getMealById(_ id: Int)
		case getMealByIngredient(_ ingredient: String)
		
		var requestURL: URL {
			var urlString = RequestConstants.baseURL
			switch self {
			case .getIngredients:
				urlString += RequestConstants.getIngredients
			case .getMealById(let id):
				urlString += RequestConstants.getMealById(id)
			case .getMealByIngredient(let ingredient):
				urlString += RequestConstants.getMealByIngredient(ingredient)
			}
			return URL(string: urlString)!
		}
	}
	
	func getIngredients(completion: @escaping IngredientsCompletion) {
		let request = MealDBRequest.getIngredients
		download(url: request.requestURL) { [weak self] in
			self?.decodeResponse(data: $0, error: $1,
								 to: GetIngredientsResponse.self) { result, errorMsg in
									if let message = errorMsg {
										print("error: \(message)")
									}
									completion(result?.meals ?? [])
			}
		}
	}
	
	func getMealById(_ id: Int, completion: @escaping MealCompletion) {
		let request = MealDBRequest.getMealById(id)
		download(url: request.requestURL) { [weak self] in
			self?.decodeResponse(data: $0, error: $1,
								 to: GetMealsResponse.self) { result, errorMsg in
									if let message = errorMsg {
										print("error: \(message)")
									}
									completion(result?.meals.first)
			}
		}
	}
	
	func getMealsByIngredient(_ ingredient: String, completion: @escaping MealsCompletion) {
		guard let ingredientUrlEncoded = ingredient
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
				fatalError("unable to encode ingredient string")
		}
		let request = MealDBRequest.getMealByIngredient(ingredientUrlEncoded)
		download(url: request.requestURL) { [weak self] in
			self?.decodeResponse(data: $0, error: $1,
								 to: GetMealsResponse.self) { result, errorMsg in
									if let message = errorMsg {
										print("error: \(message)")
									}
									completion(result?.meals ?? [])
			}
		}
	}
}
