//
//  IngredientsListViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

protocol IngredientsListViewControllerDelegate: class {
	func shouldGoToIngredientDetailView(ingredient: Ingredient)
}

class IngredientsListViewController: UIViewController {
	
	let dataProvider = DataProvider()
	
	var ingredients: [Ingredient]?
	
	private var progressHUD: MBProgressHUD?
	
	weak var delegate: IngredientsListViewControllerDelegate?
    
	lazy var tableView: UITableView = {
		let tbv = UITableView()
		
		let nib = UINib(nibName: "IngredientTableViewCell", bundle: nil)
		tbv.register(nib, forCellReuseIdentifier: "cell")
		
		tbv.delegate = self
		tbv.dataSource = self
		return tbv
	}()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		fetchIngredientsList()
		configureView()
    }
	
	private func fetchIngredientsList() {
		
		dataProvider.getIngredients { [weak self] ingredients, isRemote in
			
			guard let self = self else { return }
			
			self.ingredients = ingredients
			self.tableView.reloadData()
			
			if isRemote {
				self.progressHUD?.hide(animated: true)
			} else if ingredients.isEmpty {
				self.progressHUD = MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
			}
			
		}
	}
	
	private func configureView() {
		view.backgroundColor = .white
		
		title = "Choose an ingredient that you have"
		
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func selectedIngredient(_ ingredient: Ingredient) {
		delegate?.shouldGoToIngredientDetailView(ingredient: ingredient)
	}
}

extension IngredientsListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if let ingredient = ingredients?[indexPath.row] {
			selectedIngredient(ingredient)
		}
	}
}

extension IngredientsListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ingredients?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IngredientTableViewCell,
			let ingredient = ingredients?[indexPath.row] else {
			return UITableViewCell()
		}
		
		cell.configureWithIngredient(ingredient)
		return cell
	}
}
