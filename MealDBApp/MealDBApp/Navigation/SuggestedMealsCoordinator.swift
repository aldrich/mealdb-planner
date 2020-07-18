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
		showIngredientsListView()
	}
	
	// this is the root of the navigation
	func showIngredientsListView() {
		let vc = IngredientsListViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
	
	func showIngredientDetailsView(overRoot: Bool = false) {
		let vc = IngredientDetailsViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
	
	func showMealDetailsView(overRoot: Bool = false) {
		let vc = MealDetailsViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
}

extension SuggestedMealsCoordinator: IngredientsListViewControllerDelegate {

	func shouldGoToIngredientDetailView() {
		showIngredientDetailsView()
	}
}

extension SuggestedMealsCoordinator: IngredientDetailsViewControllerDelegate {
	
	func shouldGoToMealDetailView() {
		showMealDetailsView()
	}
}

extension SuggestedMealsCoordinator: MealDetailsViewControllerDelegate {
	func shouldDoX() {
		delegate?.shouldShowFavorites()
	}	
}
