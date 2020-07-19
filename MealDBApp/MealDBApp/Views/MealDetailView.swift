//
//  MealDetailView.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class MealDetailView: UIView {

	var meal: Meal? {
		didSet {
			
			// full view image URL, might not yet be loaded.
			let urlStr = self.meal?.strMealThumb?
				.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			let url = URL(string: urlStr!)!
			
			// thumb image URL, possibly already loaded.
			let thumbUrl = urlStr! + "/preview"
			
			let placeholder = SDImageCache.shared.imageFromCache(forKey: thumbUrl)
			
			thumbImageView.sd_setImage(with: url, placeholderImage: placeholder)
			mealNameLabel.text = meal?.strMeal
			instructionsLabel.text = meal?.strInstructions
		}
	}
	
	@IBOutlet var contentView: UIView! {
		didSet {
			contentView.backgroundColor = .white
		}
	}
	
	@IBOutlet weak var mealNameLabel: UILabel! {
		didSet {
			mealNameLabel.backgroundColor = .white
		}
	}
	
	@IBOutlet weak var instructionsLabel: UILabel! {
		didSet {
			instructionsLabel.backgroundColor = .white
		}
	}
	
	@IBOutlet weak var instructionsHeaderLabel: UILabel! {
		didSet {
			instructionsHeaderLabel.backgroundColor = .white
		}
	}
	
	@IBOutlet weak var thumbImageView: UIImageView! {
		didSet {
			thumbImageView.contentMode = .scaleAspectFill
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

		Bundle.main.loadNibNamed("MealDetailView",
								 owner: self,
								 options: nil)
		
		addSubview(contentView)
		
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	
}
