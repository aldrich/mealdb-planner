//
//  MealDetailView.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SDWebImage

class MealDetailView: UIView {

	var meal: Meal? {
		didSet {

			let urlStr = self.meal?.strMealThumb?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			let url = URL(string: urlStr!)!
			thumbImageView.sd_setImage(with: url)
			
			label1.text = meal?.strMeal
			label2.text = meal?.strInstructions
			
		}
	}
	@IBOutlet weak var label1: UILabel!
	
	@IBOutlet weak var label2: UILabel!
	
	@IBOutlet weak var thumbImageView: UIImageView! {
		didSet {
			thumbImageView.contentMode = .scaleAspectFill
			thumbImageView.backgroundColor = .white
		}
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}
	
	func configure() {
		Bundle.main.loadNibNamed("MealDetailView", owner: self, options: nil)
		addSubview(contentView)
		contentView.frame = self.bounds
	}
	
	@IBOutlet var contentView: UIView!
}
