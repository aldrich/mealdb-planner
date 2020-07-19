//
//  SuggestedMealsCoordinator.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol SuggestedMealsCoordinatorDelegate: AnyObject {
	
	func shouldShowFavorites()
}

class SuggestedMealsCoordinator: CoordinatorBase {
	
	weak var delegate: SuggestedMealsCoordinatorDelegate?
	
	init(navigationController: UINavigationController) {
		super.init()
		self.navigationController = navigationController
	}
	
	override func start() {
		
		// DEBUG
//		if let meal = Cache().getMeal(id: 52940) { // brown stew chicken
//			showMealDetailsView(meal: meal)
//		} else {
		
			showIngredientsListView()
//		}
	}
	
	// this is the root of the navigation
	func showIngredientsListView() {
		let vc = IngredientsListViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
	
	func showIngredientDetailsView(ingredient: Ingredient, overRoot: Bool = false) {
		let vc = IngredientDetailsViewController(ingredient: ingredient)
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
	
	func showMealDetailsView(meal: Meal, overRoot: Bool = false) {
		let vc = MealDetailsViewController(meal: meal)
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
}

extension SuggestedMealsCoordinator: IngredientsListViewControllerDelegate {
	
	func shouldGoToIngredientDetailView(ingredient: Ingredient) {
		showIngredientDetailsView(ingredient: ingredient)
	}
}

extension SuggestedMealsCoordinator: IngredientDetailsViewControllerDelegate {
	func shouldGoToMealDetailView(meal: Meal) {
		showMealDetailsView(meal: meal)
	}
}

extension SuggestedMealsCoordinator: MealDetailsViewControllerDelegate {}
