//
//  FavoritesCoordinator.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol FavoritesCoordinatorDelegate: AnyObject {
	
	func finished(coordinator: CoordinatorProtocol?)
}

class FavoritesCoordinator: CoordinatorBase {
	
	weak var delegate: FavoritesCoordinatorDelegate?
	
	init(navigationController: UINavigationController) {
		super.init()
		self.navigationController = navigationController
	}
	
	override func start() {
		let vc = FavoritesViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: false)
	}
}

extension FavoritesCoordinator: FavoritesViewControllerDelegate {
	
	func shouldDismiss() {
		self.navigationController.dismiss(animated: true) { [weak self] in
			self?.delegate?.finished(coordinator: self)
		}
	}
}
