//
//  MealTableViewCell.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SDWebImage

class MealTableViewCell: UITableViewCell {

	@IBOutlet weak var thumbImageView: UIImageView! {
		didSet {
			thumbImageView.layer.cornerRadius = 4
		}
	}
	
	@IBOutlet weak var mealNameLabel: UILabel! {
		didSet {
			mealNameLabel.backgroundColor = .clear
		}
	}
	
	func configureWithMeal(_ meal: Meal) {
		mealNameLabel.text = meal.strMeal
		configureThumb(meal)
	}
	
	private func configureThumb(_ meal: Meal) {
		if let url = meal.getImageUrl(isThumb: true) {
			thumbImageView.sd_setImage(with: url) { [weak self] (_, e, t, u) in
				if e != nil {
					let unavailableImage = UIImage(named: "meal-na")
					SDImageCache.shared.store(unavailableImage, forKey: url.absoluteString)
					self?.thumbImageView.image = unavailableImage
				}
			}
		}
	}
}
