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
	
	@IBOutlet weak var typeLabel: UILabel!
		{
		didSet {
			typeLabel.backgroundColor = .clear
		}
	}
	
	func configureWithIngredient(_ ingredient: Ingredient) {
		nameLabel?.text = ingredient.strIngredient
		configureImage(ingredient)
	}
	
	private func configureImage(_ ingredient: Ingredient) {
		let urlString = String(format: "https://www.themealdb.com/images/ingredients/%@-small.png", ingredient.strIngredient)
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		
		
		let url = URL(string: urlString!)!
		
		thumbImageView.sd_setImage(with: url)
		
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
