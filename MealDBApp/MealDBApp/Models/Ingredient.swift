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

struct Ingredient: Codable {
	let idIngredient: String
	let strIngredient: String
	let strDescription: String?
	let strType: String?
}

extension Ingredient {
	init(id: Int, name: String, desc: String? = nil, type: String? = nil) {
		self.init(idIngredient: "\(id)", strIngredient: name, strDescription: desc, strType: type)
	}
}