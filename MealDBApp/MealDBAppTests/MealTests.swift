//
//  MealTests.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import XCTest
@testable import MealDBApp

class MealTests: XCTestCase {
	
	override func setUpWithError() throws {}
	
	override func tearDownWithError() throws {}
	
	private func getTestMeal() -> Meal? {
		if let data = Bundle(for: type(of: self))
			.jsonData(named: "meal"),
			let response = try? data.decoded(as: GetMealsResponse.self),
			let meal = response.meals?.first {
			return meal
		}
		return nil
	}
	
	func testGetMealAreaAndCategory() throws {
		// from json-data.bundle/meal.json
		let meal: Meal! = getTestMeal()
		let areaAndCategory = meal.getAreaAndCategory()
		XCTAssertEqual(areaAndCategory, "Chicken • Japanese")
	}
	// TODO: when either or both of area / category is blank/nil
	
	func testGetMealInstructions() throws {
		let meal = Meal(id: 1, name: "Buttered Bread", instructions: "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\n\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat.")
		
		let expected = "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat."
		
		XCTAssertEqual(meal.getInstructionsClean(), expected)
	}
	
	func testGetMealIngredientsList() {
		// from json-data.bundle/meal.json
		let meal: Meal! = getTestMeal()
		let list = meal.getIngredientsList().joined(separator: ", ")
		
		XCTAssertEqual(list, "• 3/4 cup ✕ soy sauce, • 1/2 cup ✕ water, • 1/4 cup ✕ brown sugar, • 1/2 teaspoon ✕ ground ginger, • 1/2 teaspoon ✕ minced garlic, • 4 tablespoons ✕ cornstarch, • 2 ✕ chicken breasts, • 1 (12 oz.) ✕ stir-fry vegetables, • 3 cups ✕ brown rice")
	}

	func testGetImageUrl() {
		
		let meal = Meal(id: 1, name: "sample", mealThumb: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")
		
		let urlBig = meal.getImageUrl()
		let urlSmall = meal.getImageUrl(isThumb: true)
		
		XCTAssertEqual(urlBig?.absoluteString,
					   "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")
		
		XCTAssertEqual(urlSmall?.absoluteString,
					   "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg/preview")
	}
}
