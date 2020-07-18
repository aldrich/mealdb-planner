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

}
