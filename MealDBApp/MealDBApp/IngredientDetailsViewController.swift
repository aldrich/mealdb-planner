//
//  IngredientDetailsViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

protocol IngredientDetailsViewControllerDelegate: class {
	func shouldGoToMealDetailView(meal: Meal)
}

class IngredientDetailsViewController: UIViewController {

	let dataProvider = DataProvider()
	
	var meals: [Meal]?
	
	private var progressHUD: MBProgressHUD?
	
	weak var delegate: IngredientDetailsViewControllerDelegate?
	
	let ingredient: Ingredient
	
	lazy var tableView: UITableView = {
		let tbv = UITableView()

		let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
		tbv.register(nib, forCellReuseIdentifier: "cell")

		tbv.delegate = self
		tbv.dataSource = self
		return tbv
	}()
	
	init(ingredient: Ingredient) {
		self.ingredient = ingredient
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchMeals()
		configureView()
    }

	private func configureView() {
		view.backgroundColor = .white
		
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	private func fetchMeals() {
		progressHUD = MBProgressHUD.showAdded(to: (navigationController?.view)!, animated: true)
		
		let name = ingredient.strIngredient
		dataProvider.getMeals(ingredientName: name) { [weak self] meals, isRemote in
			
			self?.meals = meals
			self?.tableView.reloadData()
			
			if isRemote {
				self?.progressHUD?.hide(animated: true)
			}
		}
	}
	
	func selectedMeal(_ meal: Meal) {
		delegate?.shouldGoToMealDetailView(meal: meal)
	}
}

extension IngredientDetailsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		if let meal = meals?[indexPath.row] {
			selectedMeal(meal)
		}
	}
}

extension IngredientDetailsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meals?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MealTableViewCell, let meal = meals?[indexPath.row] else {
			return UITableViewCell()
		}
		
		
		// cell.textLabel?.text = meal.strMeal
		cell.configureWithMeal(meal)
		return cell
	}
	
	
}
