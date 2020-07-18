//
//  IngredientDetailsViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol IngredientDetailsViewControllerDelegate: class {
	func shouldGoToMealDetailView()
}

class IngredientDetailsViewController: UIViewController {

	weak var delegate: IngredientDetailsViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .cyan
		
		navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "next", style: .plain, target: self, action: #selector(nextScreen))
    }

	@objc func nextScreen(sender: Any) {
		delegate?.shouldGoToMealDetailView()
	}
}
