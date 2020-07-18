//
//  CacheTests.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import XCTest
@testable import MealDBApp

class CacheTests: XCTestCase {

	var mockPersistence: MockPersistence!
	
	var cache: CacheProtocol!
	
    override func setUpWithError() throws {
		try super.setUpWithError()
		mockPersistence = MockPersistence()
		cache = Cache(persistence: mockPersistence)
    }

	override func tearDownWithError() throws {}

    func testGetIngredients() throws {
        
		let allKey = Cache.Constants.allIngredientsKey
		
		mockPersistence.dict = [
			allKey: IngredientCollection(key: allKey, ingredientIds: [1, 2, 3]),
			"1": Ingredient(id: 1, name: "Carrot"),
			"2": Ingredient(id: 2, name: "Bread"),
			"3": Ingredient(id: 3, name: "Onion"),
		] as [String: Cacheable]
		
		let ingredients = cache.getIngredients()
		
		XCTAssertNotNil(ingredients)
		XCTAssertEqual(ingredients!.map { $0.strIngredient }.joined(separator: ", "),
					   "Carrot, Bread, Onion")
    }
	
	func testSetIngredients() throws {
	
		mockPersistence.dict = [:]
		
		let ingredients: [Ingredient] = [
			.init(id: 41, name: "Beets"),
			.init(id: 42, name: "Garlic"),
			.init(id: 43, name: "Chicken"),
		]
		
		cache.setIngredients(ingredients)
		
		let dict = mockPersistence.dict
		
		XCTAssertNotNil(dict)
		XCTAssertEqual(Array(dict!.keys).sorted(),
					   ["all-ingredients", "41", "42", "43"].sorted())
	}

	// TODO: other methods in the Cache
}
