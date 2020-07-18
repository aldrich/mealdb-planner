//
//  DataProviderTests.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import XCTest
@testable import MealDBApp

class DataProviderTests: XCTestCase {

	var dataProvider: DataProviderProtocol!
	
	var mockApiClient: MockAPIClient!
	
	var mockCache: MockCache!
	
    override func setUpWithError() throws {
		try super.setUpWithError()
		
		mockApiClient = MockAPIClient()
		mockCache = MockCache()
		dataProvider = DataProvider(apiClient: mockApiClient, cache: mockCache)
    }

    override func tearDownWithError() throws {}

    func testGetIngredients() throws {
		let expect = expectation(description: "callback is made a second time with isRemote=true")
		
		mockCache.allIngredients = [
			.init(id: 1, name: "butter"),
			.init(id: 2, name: "beans"),
			.init(id: 3, name: "celery"),
		]
		
		mockApiClient.ingredients = [
			.init(id: 1, name: "bread"),
			.init(id: 2, name: "beans"),
			.init(id: 3, name: "celery"),
			.init(id: 4, name: "eggs"),
			.init(id: 5, name: "bacon"),
		]
		
		var localIngredients: [Ingredient]?
		var remoteIngredients: [Ingredient]?
		
		dataProvider.getIngredients { ingredients, isRemote in
			if isRemote {
				remoteIngredients = ingredients
				expect.fulfill()
			} else {
				localIngredients = ingredients
			}
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			
			XCTAssertNotNil(localIngredients)
			XCTAssertNotNil(remoteIngredients)
			
			XCTAssertFalse(localIngredients!.isEmpty)
			XCTAssertFalse(remoteIngredients!.isEmpty)
			
			let localIds = localIngredients!
				.map { $0.idIngredient }
				.joined(separator: ", ")
			
			let remoteIds = remoteIngredients!
				.map { $0.idIngredient }
				.joined(separator: ", ")
			
			XCTAssertEqual(localIds, "1, 2, 3")
			XCTAssertEqual(remoteIds, "1, 2, 3, 4, 5")
		}
    }
	
	func testGetMealsById() throws {
		
		let expect = expectation(description: "callback is made a second time with isRemote=true")
		
		let id = 7
		
		mockCache.mealById = [
			id: .init(id: 89, name: "mashed potatoes-0")
		]
		
		mockApiClient.mealById = [
			id: .init(id: 89, name: "mashed potatoes-1")
		]
		
		var remoteMeal: Meal?
		var localMeal: Meal?
		
		dataProvider.getMeal(id: id) { meal, isRemote in
			if isRemote {
				remoteMeal = meal
				expect.fulfill()
			} else {
				localMeal = meal
			}
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			
			XCTAssertNotNil(localMeal)
			XCTAssertEqual(localMeal!.strMeal, "mashed potatoes-0")
			XCTAssertNotNil(remoteMeal)
			XCTAssertEqual(remoteMeal!.strMeal, "mashed potatoes-1")
		}
	}

	func testGetMealsByIngredient() throws {
		let expect = expectation(description: "callback is made a second time with isRemote=true")
		
		let ingredientName = "Green Beans"

		mockApiClient.mealsByIngredient = [
			ingredientName: [
				.init(id: 52911, name: "Summer Pistou"),
				.init(id: 52869, name: "Tahini Lentils"),
				.init(id: 52814, name: "Thai Green Curry"),
			]
		]
			
		mockCache.mealsByIngredient = [
			ingredientName: [
				.init(id: 52911, name: "Summer Pistou-cached"),
				.init(id: 52869, name: "Tahini Lentils-cached"),
				.init(id: 52814, name: "Thai Green Curry-cached"),
			]
		]
		
		var remoteMeals: [Meal]?
		var localMeals: [Meal]?
		
		dataProvider.getMeals(ingredientName: ingredientName) { meals, isRemote in
			if isRemote {
				remoteMeals = meals
				expect.fulfill()
			} else {
				localMeals = meals
			}
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			
			XCTAssertNotNil(localMeals)
			XCTAssertFalse(localMeals!.isEmpty)
			
			XCTAssertNotNil(remoteMeals)
			XCTAssertFalse(remoteMeals!.isEmpty)
			
			let localNames = localMeals!.map { $0.strMeal }.joined(separator: ", ")
			let remoteNames = remoteMeals!.map { $0.strMeal }.joined(separator: ", ")
			
			XCTAssertEqual(localNames, "Summer Pistou-cached, Tahini Lentils-cached, Thai Green Curry-cached")
			XCTAssertEqual(remoteNames, "Summer Pistou, Tahini Lentils, Thai Green Curry")
		}
	}
}
