//
//  MealDetailsViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol MealDetailsViewControllerDelegate: class {
	// func shouldGoToMealDetailView()
	func shouldDoX()
}

class MealDetailsViewController: UIViewController {

	weak var delegate: MealDetailsViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .magenta
        
		navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "next", style: .plain, target: self, action: #selector(nextScreen))
    }

	@objc func nextScreen(sender: Any) {
		delegate?.shouldDoX()
	}
}
