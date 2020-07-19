//
//  FavoritesViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerDelegate: class {
	func shouldDismiss()
}

class FavoritesViewController: UIViewController {
	
	weak var delegate: FavoritesViewControllerDelegate?
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "dismiss",
															style: .plain,
															target: self,
															action: #selector(dismiss))
	}
	
	@objc func dismiss(sender: Any) {
		delegate?.shouldDismiss()
	}
}

