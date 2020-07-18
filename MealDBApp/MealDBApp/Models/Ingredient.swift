//
//  Ingredient.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

struct GetIngredientsResponse: Decodable {
	let meals: [Ingredient]
}

struct Ingredient: Decodable {
	let idIngredient: String
	let strIngredient: String
	let strDescription: String?
	let strType: String?
}
