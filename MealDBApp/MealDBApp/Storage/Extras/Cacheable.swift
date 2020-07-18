//
//  Cacheable.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

protocol Cacheable: Codable {
	var key: String { get }
}

extension Meal: Cacheable {
	var key: String {
		return idMeal
	}
}

extension Ingredient: Cacheable {
	var key: String {
		return idIngredient
	}
}
