//
//  MealDetailsViewController.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SnapKit

protocol MealDetailsViewControllerDelegate: class {
	func shouldDoX()
}

class MealDetailsViewController: UIViewController {

	weak var delegate: MealDetailsViewControllerDelegate?
	
	let dataProvider = DataProvider()
	
	var meal: Meal
	
	let detailView: MealDetailView = {
		let view = MealDetailView()
		return view
	}()
	
	let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
		return scrollView
	}()
	
	init(meal: Meal) {
		self.meal = meal
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = meal.strMeal
		view.backgroundColor = .white
        
		fetchMealDetails()
		setupView()
		
		configureView()
    }
	
	func fetchMealDetails() {
		guard let id = Int(meal.idMeal) else {
			fatalError("unable to get meal id.")
		}
		dataProvider.getMeal(id: id) { [weak self] meal, isRemote in
			if let meal = meal {
				self?.meal = meal
			}
			self?.configureView()
		}
	}

	private func setupView() {
		// edgesForExtendedLayout = UIRectEdge()
		
		view.addSubview(scrollView)
		
		scrollView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		scrollView.addSubview(detailView)
		
		detailView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.left.bottom.equalToSuperview()
		}
	}
	
	private func configureView() {
		detailView.meal = meal
	}
}
