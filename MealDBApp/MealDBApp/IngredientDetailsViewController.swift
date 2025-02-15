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
		tbv.separatorStyle = .none
		tbv.delegate = self
		tbv.dataSource = self
		return tbv
	}()
	
	lazy var emptyViewLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "ChunkFive-Regular", size: 20)
		label.text = "Sorry, no meals found."
		view.addSubview(label)
		label.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		label.isHidden = true
		return label
	}()
	
	lazy var ingredientDetailView: IngredientDetailView = {
		let view = IngredientDetailView()
		return view
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
		
		title = ingredient.strIngredient
		
		navigationController?.navigationBar.isTranslucent = false
		
		ingredientDetailView.ingredient = ingredient
		
		view.backgroundColor = .white
		
		view.addSubview(ingredientDetailView)
		
		ingredientDetailView.snp.makeConstraints { make in
			make.top.leading.trailing.equalToSuperview()
			// height determined internally by view
		}
		
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints { make in
			make.bottom.leading.trailing.equalToSuperview()
			make.top.equalTo(ingredientDetailView.snp.bottom)
		}
		
		view.addSubview(emptyViewLabel)
		
		emptyViewLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
	
	private func fetchMeals() {
		
		let name = ingredient.strIngredient
		
		dataProvider.getMeals(ingredientName: name) { [weak self] meals, isRemote in
			guard let self = self else { return }
			
			self.emptyViewLabel.isHidden = true
			self.tableView.isHidden = false
			
			if isRemote {
				self.progressHUD?.hide(animated: true)
				
				if self.meals == nil {
					self.meals = meals
					self.tableView.reloadData()
				}
				
				if self.meals == nil || self.meals!.isEmpty {
					// if meals empty, show an empty view.
					self.emptyViewLabel.isHidden = false
					self.tableView.isHidden = true
				}
				
			} else {
				if meals.isEmpty {
					self.progressHUD = MBProgressHUD
						.showAdded(to: (self.navigationController?.view)!,
								   animated: true)
				} else {
					self.meals = meals
					self.tableView.reloadData()
				}
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
		
		tableView.deselectRow(at: indexPath, animated: true)
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
		cell.configureWithMeal(meal)
		return cell
	}
}
