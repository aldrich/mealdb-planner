//
//  Ingredient.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

struct GetIngredientsResponse: Decodable {
	let meals: [Ingredient]?
}

struct Ingredient: Codable {
	let idIngredient: String
	let strIngredient: String
	var strDescription: String?
	let strType: String?
}

extension Ingredient {
	init(id: Int, name: String, desc: String? = nil, type: String? = nil) {
		self.init(idIngredient: "\(id)", strIngredient: name, strDescription: desc, strType: type)
	}
}

extension Ingredient {

	func getImageUrl(isThumb: Bool = false) -> URL? {
		let formatStr = "https://www.themealdb.com/images/ingredients/%@.png"
		let ingredientStr = String(format: "%@%@", strIngredient, isThumb ? "-small" : "")
		let urlString = String(format: formatStr, ingredientStr)
			.lowercased()
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		return URL(string: urlString!)
	}
}
