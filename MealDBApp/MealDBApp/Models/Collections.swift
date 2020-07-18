//
//  Collections.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

struct MealCollection: Cacheable {
	var key: String
	var mealIds: [Int]
}

struct IngredientCollection: Cacheable {
	var key: String
	var ingredientIds: [Int]
}
