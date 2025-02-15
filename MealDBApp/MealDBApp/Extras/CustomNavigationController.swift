//
//  UINavigationController+Extensions.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		setBackButton()
		super.pushViewController(viewController, animated: animated)
	}
	
	private func setBackButton() {
		let backButton = UIBarButtonItem()
		backButton.title = ""
		backButton.tintColor = Colors.secondary
		viewControllers.last?.navigationItem.backBarButtonItem = backButton
	}
}
