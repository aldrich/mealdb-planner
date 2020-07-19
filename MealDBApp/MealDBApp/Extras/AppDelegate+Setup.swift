//
//  AppDelegate+Setup.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

extension AppDelegate {
	
	func setUpBackBarButtonItemGeneralAppearance() {
		let backImage = UIImage(imageLiteralResourceName: "back_button_item")
			.withRenderingMode(.alwaysTemplate)
		UINavigationBar.appearance().backIndicatorImage = backImage
		UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
	}
	
}
