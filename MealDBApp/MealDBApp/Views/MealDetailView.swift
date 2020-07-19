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
			
			guard let meal = meal else { return }
			
			// full view image URL, might not yet be loaded.
			let urlStr = self.meal?.strMealThumb?
				.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			let url = URL(string: urlStr!)!
			
			
				// thumb image URL, possibly already loaded.
				let thumbUrlStr = urlStr! + "/preview"
				
				let placeholder = SDImageCache.shared
					.imageFromCache(forKey: thumbUrlStr)
				
				thumbImageView.sd_setImage(with: url,
										   placeholderImage: placeholder) {
											[weak self] image, error, cacheType, url in
											
											if let _ = SDImageCache.shared.imageFromCache(forKey: urlStr) {
											
												// only remove it when replaced with final image
												self?.thumbImageView.removeBlur()
											}
				}
			
			mealNameLabel.text = meal.strMeal.uppercased()
			
			let areaAndCategory = [
				meal.strCategory,
				meal.strArea
				].compactMap { $0 }.joined(separator: " • ")
			
			categoryAreaLabel.text = areaAndCategory
			
			let instructionLabelStr = (meal.strInstructions ?? "")
				.replacingOccurrences(of: "\r\n\r\n", with: "\r\n")
						
			setInstructionLabel(text: instructionLabelStr)
			
			setIngredientsLabel(list: meal.ingredientsList)
		}
	}
	
	private func setInstructionLabel(text: String) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 4
		paragraphStyle.paragraphSpacing = 8
		paragraphStyle.alignment = .justified
		paragraphStyle.firstLineHeadIndent = 12
		let attrString = NSMutableAttributedString(string: text)
		attrString.addAttribute(.paragraphStyle,
								value:paragraphStyle,
								range: NSMakeRange(0, attrString.length))
		instructionsLabel.attributedText = attrString
		instructionsHeaderLabel.isHidden = text.isEmpty
	}
	
	private func setIngredientsLabel(list: [String]) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 3
		
		let text = list.joined(separator: "\r\n")
		
		let attrString = NSMutableAttributedString(string: text)
		attrString.addAttribute(.paragraphStyle,
								value:paragraphStyle,
								range: NSMakeRange(0, attrString.length))
		ingredientsLabel.attributedText = attrString
		ingredientsHeaderLabel.isHidden = text.isEmpty
	}
	
	@IBOutlet weak var thumbImageView: UIImageView! {
		didSet {
			thumbImageView.contentMode = .scaleAspectFill
			
			let transition = SDWebImageTransition.fade
			thumbImageView.sd_imageTransition = transition
			
			thumbImageView.addBlur()
		}
	}
	
	@IBOutlet var contentView: UIView! {
		didSet {
			contentView.backgroundColor = .systemBackground
		}
	}
	
	@IBOutlet weak var mealNameLabel: UILabel! {
		didSet {
			mealNameLabel.backgroundColor = .systemBackground
		}
	}
	
	@IBOutlet weak var categoryAreaLabel: UILabel! {
		didSet {
			categoryAreaLabel.backgroundColor = .systemBackground
		}
	}
	
	@IBOutlet weak var instructionsHeaderLabel: UILabel! {
		didSet {
			instructionsHeaderLabel.isHidden = true
			instructionsHeaderLabel.layer.cornerRadius = 2
			instructionsHeaderLabel.backgroundColor = .init(white: 0, alpha: 0.1)
			instructionsHeaderLabel.layer.masksToBounds = true
		}
	}
	
	@IBOutlet weak var instructionsLabel: UILabel! {
		didSet {
			instructionsLabel.backgroundColor = .systemBackground
		}
	}
	
	@IBOutlet weak var ingredientsHeaderLabel: UILabel! {
		didSet {			
			ingredientsHeaderLabel.isHidden = true
			ingredientsHeaderLabel.layer.cornerRadius = 2
			ingredientsHeaderLabel.backgroundColor = .init(white: 0, alpha: 0.1)
			ingredientsHeaderLabel.layer.masksToBounds = true
		}
	}
	
	@IBOutlet weak var ingredientsLabel: UILabel! {
		didSet {
			ingredientsLabel.backgroundColor = .systemBackground
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
