//
//  MockObjects.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
@testable import MealDBApp

class MockAPIClient: APIClient {
	func getMealsByIngredient(_ ingredient: String, completion: @escaping MealsCompletion) {
		
	}
	
	func getMealById(_ id: Int, completion: @escaping MealCompletion) {
		completion(nil)
	}
	
	
	func getIngredients(completion: @escaping IngredientsCompletion) {
		completion([])
	}
}
