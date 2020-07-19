//
//  Ingredient.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

struct GetIngredientsResponse: Decodable {
	let meals: [Ingredient]?
}

struct Ingredient: Codable {
	let idIngredient: String
	let strIngredient: String
	var strDescription: String?
	let strType: String?
}

extension Ingredient {
	init(id: Int, name: String, desc: String? = nil, type: String? = nil) {
		self.init(idIngredient: "\(id)", strIngredient: name, strDescription: desc, strType: type)
	}
}

extension Ingredient {
	
	var smallImageUrl: URL? {
		let formatStr = "https://www.themealdb.com/images/ingredients/%@-small.png"
		let urlString = String(format: formatStr, strIngredient)
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		return URL(string: urlString!)
	}
}
