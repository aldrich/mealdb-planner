//
//  AppDelegate.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/17/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	private var appCoordinator: ApplicationCoordinator!

	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		appCoordinator = ApplicationCoordinator(window: window!)
		appCoordinator.start()
		window?.makeKeyAndVisible()
		
		setUpBackBarButtonItemGeneralAppearance()
		
		return true
	}
}
