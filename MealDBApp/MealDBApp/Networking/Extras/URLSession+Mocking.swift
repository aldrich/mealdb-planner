//
//  URLSession+Mocking.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

// only reason we have these protocols is to allow them to be easily substituted
// for mock versions during our unit test
protocol URLSessionProtocol {
	
	typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
	
	func dataTask(request: URLRequest,
				  completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
	func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
	
	func dataTask(request: URLRequest,
				  completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
		return dataTask(with: request, completionHandler: completionHandler)
	}
}
