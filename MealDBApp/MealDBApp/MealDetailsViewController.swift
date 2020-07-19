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

	// TODO: show details about the meal, preparation, pictures, etc.
	
	weak var delegate: MealDetailsViewControllerDelegate?
	
	let meal: Meal
	
	let detailView: MealDetailView = {
		let view = MealDetailView()
		return view
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
        
		configureView()
    }

	private func configureView() {

		edgesForExtendedLayout = UIRectEdge()
		
		view.addSubview(detailView)
		
		detailView.meal = meal
		
		detailView.snp.makeConstraints { make in
			
			make.top.equalTo(view.safeAreaInsets.top)
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(320)
		}

		

	}
}
