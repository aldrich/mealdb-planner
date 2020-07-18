//
//  Cache.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
import PINCache

protocol MealDBCache {
	
	func getMeal(id: Int) -> Meal?
	
	func addMeal(_ meal: Meal)
	
	func getIngredient(id: Int) -> Ingredient?

	func addIngredient(_ ingredient: Ingredient)
	
	
//
//	func getMealFavorites() -> [Int]
//
//	func setMealFavorites(ids: [Int])
//
//	func getIngredientFavorites() -> [Int]
//
//	func setIngredientFavorites(ids: [Int])
//
//	func getMeals(ingredientId: Int) -> [Meal]
//
//	func setMeals(meals: [Meal]?, ingredientId: Int)
	
}

class MealDBCache: MealDBCache {
	
	let persistence: Persistence
	
	init(persistence: Persistence) {
		self.persistence = persistence
	}
	
	func getMeal(id: Int) -> Meal? {
		let idStr = "\(id)"
		return persistence.getObjectForKey(idStr)
	}
	
	func addMeal(_ meal: Meal) {
		persistence.setObject(meal)
	}
	
	func getIngredient(id: Int) -> Ingredient? {
		let idStr = "\(id)"
		return persistence.getObjectForKey(idStr)
	}
	
	func addIngredient(_ ingredient: Ingredient) {
		persistence.setObject(ingredient)
	}
	
//	func addIngredient(_ ingredient: Ingredient?, id: Int) {
//
//	}
//
//	func getMealFavorites() -> [Int] {
//		return []
//	}
//
//	func setMealFavorites(ids: [Int]) {
//
//	}
//
//	func getIngredientFavorites() -> [Int] {
//		return []
//	}
//
//	func getIngredient(id: Int) -> Ingredient? {
//		return nil
//	}
//
//	func setIngredientFavorites(ids: [Int]) {
//
//	}
//
//	func getMeals(ingredientId: Int) -> [Meal] {
//		return []
//	}
//
//	func setMeals(meals: [Meal]?, ingredientId: Int) {
//
//	}
}
