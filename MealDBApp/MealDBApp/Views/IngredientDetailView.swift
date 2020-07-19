//
//  IngredientDetailView.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit
import SDWebImage

class IngredientDetailView: UIView {
	
	var ingredient: Ingredient? {
		didSet {
			guard let ingredient = ingredient else { return }
			
			var ingredientDesc = ingredient.strDescription ?? ""
			if ingredientDesc.isEmpty {
				ingredientDesc = "No description found"
			}
			setDescription(text: ingredientDesc)

			let bigImageUrl = ingredient.getImageUrl()
			let thumb = getSmallImageFromCache()
			imageView.sd_setImage(with: bigImageUrl, placeholderImage: thumb)
		}
	}
	
	private func setDescription(text: String) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 1
		let attrString = NSMutableAttributedString(string: text)
		attrString.addAttribute(.paragraphStyle,
								value: paragraphStyle,
								range: NSMakeRange(0, attrString.length))
		
		descriptionLabel.attributedText = attrString
	}
	
	private func getSmallImageFromCache() -> UIImage? {
		let smallImageUrl = ingredient?.getImageUrl(isThumb: true)
		return SDImageCache.shared.imageFromCache(forKey: smallImageUrl?.absoluteString)
	}
	
	@IBOutlet weak var imageView: UIImageView! {
		didSet {
			imageView.backgroundColor = .clear
		}
	}
	
	@IBOutlet weak var descriptionLabel: UILabel! {
		didSet {
			descriptionLabel.backgroundColor = .clear
			descriptionLabel.textColor = .white
		}
	}
	
	@IBOutlet var contentView: UIView! {
		didSet {
			contentView.backgroundColor = Colors.primary
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
		
		Bundle.main.loadNibNamed("IngredientDetailView",
								 owner: self,
								 options: nil)
		
		addSubview(contentView)
		
		contentView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
