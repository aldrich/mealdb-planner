//
//  DataProvider.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

typealias IngredientsCallback = (
	_ ingredients: [Ingredient],
	_ isRemote: Bool
) -> Void

typealias MealCallback = (
	_ meals: Meal?,
	_ isRemote: Bool
	) -> Void

typealias MealsCallback = (
	_ meals: [Meal],
	_ isRemote: Bool
	) -> Void


protocol DataProviderProtocol {
	
	func getIngredients(completion: @escaping IngredientsCallback)
	
	func getMeals(ingredientName: String, completion: @escaping MealsCallback)
	
	func getMeal(id: Int, completion: @escaping MealCallback)
}

class DataProvider: DataProviderProtocol {

	let apiClient: APIClientProtocol
	let cache: CacheProtocol
	
	init(apiClient: APIClientProtocol = APIClient(),
		 cache: CacheProtocol = Cache()) {
		self.apiClient = apiClient
		self.cache = cache
	}

	func getIngredients(completion: @escaping IngredientsCallback) {
		let ingredients = cache.getIngredients()
		completion(ingredients ?? [], false)
		print("get ingredients from cache completed: \(ingredients?.count ?? 0) values")
		apiClient.getIngredients { [weak self] ingredients in
			self?.cache.setIngredients(ingredients)
			completion(ingredients, true)
			print("get ingredients from api completed: \(ingredients.count) values")
		}
	}
	
	func getMeals(ingredientName: String, completion: @escaping MealsCallback) {
		let meals = cache.getMeals(ingredientName: ingredientName)
		completion(meals ?? [], false)
		print("get meals from cache completed: \(meals?.count ?? 0) values")
		apiClient.getMealsByIngredient(ingredientName) { [weak self] meals in
			self?.cache.setMeals(meals, ingredientName: ingredientName)
			completion(meals, true)
			print("get meals from api completed: \(meals.count) values")
		}
	}
	
	func getMeal(id: Int, completion: @escaping MealCallback) {
		let meal = cache.getMeal(id: id)
		completion(meal, false)
		print("get meal from cache completed for id: \(meal?.idMeal ?? "")")
		apiClient.getMealById(id) { [weak self] meal in
			if let meal = meal {
				self?.cache.addMeal(meal)
			}
			completion(meal, true)
			print("get meal from api completed for id: \(meal?.idMeal ?? "")")
		}
	}
}
