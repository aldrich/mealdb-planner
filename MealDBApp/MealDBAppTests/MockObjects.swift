//
//  MockObjects.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
@testable import MealDBApp

class MockAPIClient: APIClientProtocol {
	
	var ingredients: [Ingredient]?
	
	var mealsByIngredient: [String: [Meal]]?
	
	var mealById: [Int: Meal]?
	
	func getMealsByIngredient(_ ingredient: String, completion: @escaping MealsCompletion) {
		completion(mealsByIngredient?[ingredient] ?? [])
	}
	
	func getMealById(_ id: Int, completion: @escaping MealCompletion) {
		completion(mealById?[id])
	}
	
	func getIngredients(completion: @escaping IngredientsCompletion) {
		completion(ingredients ?? [])
	}
}

class MockCache: CacheProtocol {
	
	var allIngredients: [Ingredient]?
	
	var mealsByIngredient: [String: [Meal]]?
	
	var mealById: [Int: Meal]?
	
	func getMeals(ingredientName: String) -> [Meal]? {
		return mealsByIngredient?[ingredientName]
	}
	
	func setMeals(_ meals: [Meal], ingredientName: String) {
		mealsByIngredient?[ingredientName] = meals
	}
	
	func getIngredients() -> [Ingredient]? {
		return allIngredients
	}
	
	func setIngredients(_ ingredients: [Ingredient]) {
		allIngredients = ingredients
	}
	
	func getMeal(id: Int) -> Meal? {
		return mealById?[id]
	}
	
	func addMeal(_ meal: Meal) {
		if let id = Int(meal.idMeal) {
			mealById?[id] = meal
		}
	}
	
	func getIngredient(id: Int) -> Ingredient? {
		return nil
	}
	
	func addIngredient(_ ingredient: Ingredient) {
	}	
}
