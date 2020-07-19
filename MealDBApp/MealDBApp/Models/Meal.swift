//
//  Meal.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

struct GetMealsResponse: Decodable {
	let meals: [Meal]?
}

struct Meal: Codable {

	let idMeal: String
	let strMeal: String

	let strCategory: String?
	let strArea: String?
	let strInstructions: String?
	let strMealThumb: String?
	
	let strIngredient1: String?
	let strIngredient2: String?
	let strIngredient3: String?
	let strIngredient4: String?
	let strIngredient5: String?
	let strIngredient6: String?
	let strIngredient7: String?
	let strIngredient8: String?
	let strIngredient9: String?
	let strIngredient10: String?
	let strIngredient11: String?
	let strIngredient12: String?
	let strIngredient13: String?
	let strIngredient14: String?
	let strIngredient15: String?
	let strIngredient16: String?
	let strIngredient17: String?
	let strIngredient18: String?
	let strIngredient19: String?
	let strIngredient20: String?
	
	let strMeasure1: String?
	let strMeasure2: String?
	let strMeasure3: String?
	let strMeasure4: String?
	let strMeasure5: String?
	let strMeasure6: String?
	let strMeasure7: String?
	let strMeasure8: String?
	let strMeasure9: String?
	let strMeasure10: String?
	let strMeasure11: String?
	let strMeasure12: String?
	let strMeasure13: String?
	let strMeasure14: String?
	let strMeasure15: String?
	let strMeasure16: String?
	let strMeasure17: String?
	let strMeasure18: String?
	let strMeasure19: String?
	let strMeasure20: String?
}

extension Meal {
	
	init(id: Int,
		 name: String,
		 category: String? = nil,
		 area: String? = nil,
		 instructions: String? = nil,
		 mealThumb: String? = nil,
		 ingredient1: String? = nil,
		 ingredient2: String? = nil,
		 ingredient3: String? = nil,
		 ingredient4: String? = nil,
		 ingredient5: String? = nil,
		 ingredient6: String? = nil,
		 ingredient7: String? = nil,
		 ingredient8: String? = nil,
		 ingredient9: String? = nil,
		 ingredient10: String? = nil,
		 ingredient11: String? = nil,
		 ingredient12: String? = nil,
		 ingredient13: String? = nil,
		 ingredient14: String? = nil,
		 ingredient15: String? = nil,
		 ingredient16: String? = nil,
		 ingredient17: String? = nil,
		 ingredient18: String? = nil,
		 ingredient19: String? = nil,
		 ingredient20: String? = nil,
		 measure1: String? = nil,
		 measure2: String? = nil,
		 measure3: String? = nil,
		 measure4: String? = nil,
		 measure5: String? = nil,
		 measure6: String? = nil,
		 measure7: String? = nil,
		 measure8: String? = nil,
		 measure9: String? = nil,
		 measure10: String? = nil,
		 measure11: String? = nil,
		 measure12: String? = nil,
		 measure13: String? = nil,
		 measure14: String? = nil,
		 measure15: String? = nil,
		 measure16: String? = nil,
		 measure17: String? = nil,
		 measure18: String? = nil,
		 measure19: String? = nil,
		 measure20: String? = nil) {
		
		self.init(idMeal: "\(id)",
				  strMeal: name,
				  strCategory: category,
				  strArea: area,
				  strInstructions: instructions,
				  strMealThumb: mealThumb,
				  strIngredient1: ingredient1,
				  strIngredient2: ingredient2,
				  strIngredient3: ingredient3,
				  strIngredient4: ingredient4,
				  strIngredient5: ingredient5,
				  strIngredient6: ingredient6,
				  strIngredient7: ingredient7,
				  strIngredient8: ingredient8,
				  strIngredient9: ingredient9,
				  strIngredient10: ingredient10,
				  strIngredient11: ingredient11,
				  strIngredient12: ingredient12,
				  strIngredient13: ingredient13,
				  strIngredient14: ingredient14,
				  strIngredient15: ingredient15,
				  strIngredient16: ingredient16,
				  strIngredient17: ingredient17,
				  strIngredient18: ingredient18,
				  strIngredient19: ingredient19,
				  strIngredient20: ingredient20,
				  strMeasure1: measure1,
				  strMeasure2: measure2,
				  strMeasure3: measure3,
				  strMeasure4: measure4,
				  strMeasure5: measure5,
				  strMeasure6: measure6,
				  strMeasure7: measure7,
				  strMeasure8: measure8,
				  strMeasure9: measure9,
				  strMeasure10: measure10,
				  strMeasure11: measure11,
				  strMeasure12: measure12,
				  strMeasure13: measure13,
				  strMeasure14: measure14,
				  strMeasure15: measure15,
				  strMeasure16: measure16,
				  strMeasure17: measure17,
				  strMeasure18: measure18,
				  strMeasure19: measure19,
				  strMeasure20: measure20)
	}
}
