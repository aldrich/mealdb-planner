//
//  Cache.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
import PINCache

protocol CacheProtocol {
	
	func getMeal(id: Int) -> Meal?
	
	func addMeal(_ meal: Meal)
	
	func getIngredient(id: Int) -> Ingredient?

	func addIngredient(_ ingredient: Ingredient)
	
	func getIngredients() -> [Ingredient]?
	
	func setIngredients(_ ingredients: [Ingredient])
	
	func getMeals(ingredientName: String) -> [Meal]?
	
	func setMeals(_ meals: [Meal], ingredientName: String)	
}

class Cache: CacheProtocol {
	
	enum Constants {
		static let allIngredientsKey = "all-ingredients"
	}
	
	let persistence: PersistenceProtocol
	
	init(persistence: PersistenceProtocol = Persistence()) {
		self.persistence = persistence
	}
	
	func getIngredients() -> [Ingredient]? {
		guard let collection: IngredientCollection =  persistence.getObjectForKey(Constants.allIngredientsKey) else {
			return nil
		}
		return collection.ingredientIds.compactMap { self.getIngredient(id: $0) }
	}
	
	func setIngredients(_ ingredients: [Ingredient]) {
		let collection = IngredientCollection(key: Constants.allIngredientsKey,
											  ingredientIds: ingredients.compactMap { Int($0.idIngredient) })
		persistence.setObject(collection)
		ingredients.forEach { persistence.setObject($0) }
	}
	
	func getMeals(ingredientName: String) -> [Meal]? {
		guard let mealCollection: MealCollection =
			persistence.getObjectForKey(ingredientName) else  {
				return nil
		}
		return mealCollection.mealIds.compactMap { self.getMeal(id: $0) }
	}
	
	func setMeals(_ meals: [Meal], ingredientName: String) {
		let collection = MealCollection(key: ingredientName,
			mealIds: meals.compactMap { Int($0.idMeal) })
		persistence.setObject(collection)
		meals.forEach { persistence.setObject($0) }
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
}
