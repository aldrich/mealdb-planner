//
//  String+Extensions.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/19/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

extension String {
	
	var asUrl: URL {
		return URL(string: self)!
	}
}
