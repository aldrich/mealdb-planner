//
//  PaddedLabel.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

public class PaddedLabel: UILabel {
	
	var insets: UIEdgeInsets = .init(top: 5, left: 12, bottom: 5, right: 12)
	
	override public func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: insets))
	}
}
