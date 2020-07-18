//
//  MealDBAAPIClientTests.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/17/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import XCTest
@testable import MealDBApp

class APIClientTests: XCTestCase {
	
	func testGetIngredients() {
		
		let expect = expectation(description: "api response returned")
		
		let session = MockSession()
		session.nextData = Bundle(for: type(of: self))
			.jsonData(named: "ingredients")
		
		let apiClient: APIClientProtocol = APIClient(session: session)
		
		var ingredients: [Ingredient]?
		
		apiClient.getIngredients { result in
			ingredients = result
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			XCTAssertNotNil(ingredients)
			XCTAssertEqual(ingredients?.count, 569)
		}
	}
	
	func testGetMealById() {
		let expect = expectation(description: "api response returned")
		
		let session = MockSession()
		session.nextData = Bundle(for: type(of: self))
			.jsonData(named: "meal")
		
		let apiClient: APIClientProtocol = APIClient(session: session)
		
		var meal: Meal?
		
		apiClient.getMealById(7) { result in
			meal = result
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			XCTAssertNotNil(meal)
			XCTAssertEqual(meal?.idMeal, "52772")
			XCTAssertEqual(meal?.strMeal, "Teriyaki Chicken Casserole")
		}
	}
	
	func testGetMealsByIngredient() {
		let expect = expectation(description: "api response returned")
		
		let session = MockSession()
		session.nextData = Bundle(for: type(of: self))
			.jsonData(named: "meals-by-ingredient")
		
		let apiClient: APIClientProtocol = APIClient(session: session)
		
		var meals: [Meal]?
		
		apiClient.getMealsByIngredient("baking powder") { result in
			meals = result
			expect.fulfill()
		}
		
		waitForExpectations(timeout: 5) { error in
			XCTAssertNil(error)
			XCTAssertNotNil(meals)
			XCTAssertEqual(meals?.count, 13)
		}
	}
}
