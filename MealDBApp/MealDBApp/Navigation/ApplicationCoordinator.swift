//
//  AppCoordinator.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: CoordinatorBase {
	
	private let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	override func start() {	
		startMainNavigation()
	}
	
	private func startMainNavigation() {
		// self.removeChildCoordinators() // seems not needed
		let navigationController = UINavigationController()
		let coordinator = SuggestedMealsCoordinator(navigationController: navigationController)
		coordinator.delegate = self
		
		start(coordinator: coordinator)
		window.rootViewController = coordinator.navigationController
		window.makeKeyAndVisible()
	}
	
	private func startFavoritesModalNavigation() {
		let navigationController = UINavigationController()
		let coordinator = FavoritesCoordinator(navigationController: navigationController)
		coordinator.delegate = self
		
		window.rootViewController?.present(navigationController, animated: true)
		start(coordinator: coordinator)
	}
}

extension ApplicationCoordinator: SuggestedMealsCoordinatorDelegate {
	func shouldShowFavorites() {
		startFavoritesModalNavigation()
	}
}

extension ApplicationCoordinator: FavoritesCoordinatorDelegate {
	func finished(coordinator: CoordinatorProtocol?) {
		guard let coordinator = coordinator else { return }
		didFinish(coordinator: coordinator)
	}
}
