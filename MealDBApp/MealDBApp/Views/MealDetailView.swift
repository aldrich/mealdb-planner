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
			
			configureImage(meal: meal)
			
			mealNameLabel.text = meal.strMeal.uppercased()
			
			categoryAreaLabel.text = meal.getAreaAndCategory()
			
			setInstructionLabel(text: meal.getInstructionsClean())
			
			setIngredientsLabel(list: meal.getIngredientsList())
		}
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
			mealNameLabel.backgroundColor = .clear
			mealNameLabel.textColor = .white
		}
	}
	
	@IBOutlet weak var categoryAreaLabel: UILabel! {
		didSet {
			categoryAreaLabel.backgroundColor = .systemBackground
			categoryAreaLabel.backgroundColor = .clear
			categoryAreaLabel.textColor = .white
		}
	}
	
	@IBOutlet weak var instructionsHeaderLabel: UILabel! {
		didSet {
			instructionsHeaderLabel.isHidden = true
			instructionsHeaderLabel.layer.cornerRadius = 2
			instructionsHeaderLabel.textColor = .white
			instructionsHeaderLabel.layer.masksToBounds = true
			instructionsHeaderLabel.backgroundColor = Colors.primary
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
			ingredientsHeaderLabel.textColor = .white
			ingredientsHeaderLabel.layer.masksToBounds = true
			ingredientsHeaderLabel.backgroundColor = Colors.primary
		}
	}
	
	@IBOutlet weak var ingredientsLabel: UILabel! {
		didSet {
			ingredientsLabel.backgroundColor = .systemBackground
		}
	}
	
	@IBOutlet weak var imageOverlay: UIView! {
		didSet {
			imageOverlay.backgroundColor = .clear
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
	
	private func updateGradientOverlay() {
		var gradientLayer: CAGradientLayer!
		
		let gradientLayers = imageOverlay.layer.sublayers?.filter { $0 is CAGradientLayer }
		
		if let layer = gradientLayers?.first as? CAGradientLayer {
			gradientLayer = layer
		} else {
			gradientLayer = CAGradientLayer()
			gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
			imageOverlay.layer.insertSublayer(gradientLayer, at: 0)
			gradientLayer.opacity = 1
		}
		gradientLayer.frame = imageOverlay.bounds
	}
	
	private func setInstructionLabel(text: String) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 4
		paragraphStyle.paragraphSpacing = 8
		paragraphStyle.alignment = .justified
		paragraphStyle.firstLineHeadIndent = 12
		let attrString = NSMutableAttributedString(string: text)
		attrString.addAttribute(.paragraphStyle,
								value: paragraphStyle,
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
								value: paragraphStyle,
								range: NSMakeRange(0, attrString.length))
		ingredientsLabel.attributedText = attrString
		ingredientsHeaderLabel.isHidden = text.isEmpty
	}
	
	private func configureImage(meal: Meal) {
		// full view image URL, might not yet be loaded.
		let url = meal.getImageUrl()!
		
		// thumb image URL, possibly already loaded.
		let thumbUrl = meal.getImageUrl(isThumb: true)
		let thumbUrlStr = thumbUrl?.absoluteString
		
		let placeholder = SDImageCache.shared
			.imageFromCache(forKey: thumbUrlStr)
		
		thumbImageView.sd_setImage(with: url, placeholderImage: placeholder) {
			[weak self] image, error, cacheType, url in
			
			if let _ = SDImageCache.shared.imageFromCache(forKey: url?.absoluteString) {
				// only remove blur after being replaced with final image
				self?.thumbImageView.removeBlur()
			}
			
			guard let image = image else { return }
			
			let size = CGSize(width: 200, height: 200)
			let resized = image.sd_resizedImage(with: size,
												scaleMode: .aspectFill)
			
			// in case a better version is found, resize it for its
			// thumbnail counterpart
			if let urlStr = url?.absoluteString {
				let key = urlStr + "/preview"
				SDImageCache.shared.store(resized, forKey: key)
			}
		}
	}
}
