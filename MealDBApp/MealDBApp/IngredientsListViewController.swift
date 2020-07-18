//
//  IngredientsListViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol IngredientsListViewControllerDelegate: class {
	func shouldGoToIngredientDetailView()
}

class IngredientsListViewController: UIViewController {
	
	weak var delegate: IngredientsListViewControllerDelegate?
    
	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .red
        // Do any additional setup after loading the view.
	
		navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "next", style: .plain, target: self, action: #selector(nextScreen))
    }
	
	@objc func nextScreen(sender: Any) {
		delegate?.shouldGoToIngredientDetailView()
	}
}
