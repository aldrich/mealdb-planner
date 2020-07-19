//
//  UIImage+Extensions.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol Blurring {
	func addBlur(_ alpha: CGFloat)
}

extension Blurring where Self: UIView {
	
	func addBlur(_ alpha: CGFloat = 1) {
		
		var effectView: UIView! = blurView
		
		if effectView == nil {
			let blurEffect = UIBlurEffect(style: .dark)
			let blurView = UIVisualEffectView(effect: blurEffect)
			
			effectView = blurView
			effectView.frame = self.bounds
			effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			
			self.addSubview(effectView)
		}
		
		effectView.alpha = alpha
	}
	
	func removeBlur(animated: Bool = true) {
		if let blurView = blurView {
			UIView.animate(withDuration: 0.3) {
				blurView.alpha = 0
			}
		}
	}
	
	var blurView: UIView? {
		return self.subviews.filter({ $0 is UIVisualEffectView }).first
	}
}

// Conformance
extension UIView: Blurring {}
