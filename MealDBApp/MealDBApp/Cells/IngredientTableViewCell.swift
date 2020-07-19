//
//  IngredientTableViewCell.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SDWebImage

class IngredientTableViewCell: UITableViewCell {

	@IBOutlet weak var thumbImageView: UIImageView! {
		didSet {
			thumbImageView.layer.cornerRadius = 3
			thumbImageView.backgroundColor = Colors.primary
			thumbImageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
			thumbImageView.layer.borderWidth = 1
		}
	}
	
	@IBOutlet weak var nameLabel: UILabel! {
		didSet {
			nameLabel.backgroundColor = .clear
		}
	}
	
	@IBOutlet weak var descriptionLabel: UILabel! {
		didSet {
			descriptionLabel.backgroundColor = .clear
		}
	}
	
	@IBOutlet weak var typeLabel: UILabel! {
		didSet {
			typeLabel.backgroundColor = .clear
		}
	}
	
	func configureWithIngredient(_ ingredient: Ingredient) {
		nameLabel?.text = ingredient.strIngredient.uppercased()
		configureImage(ingredient)
	}
	
	private func configureImage(_ ingredient: Ingredient) {
		if let url = ingredient.getImageUrl(isThumb: true) {
			thumbImageView.sd_setImage(with: url) { [weak self] (_, e, _, _) in
				if e != nil {
					self?.thumbImageView.image = UIImage(named: "ingredient-na")
				}
			}
		}
	}
}
