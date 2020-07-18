//
//  TestUtilities.swift
//  MealDBAppTests
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
@testable import MealDBApp

extension Bundle {
	
	/// Returns Data for a file found under the json-data.bundle directory,
	/// if a matching filename could be found. Note: only provide the name of the
	/// file not including the extension, which must always be "json".
	func jsonData(named filename: String, fileExtension: String = "json",
				  inSubDirectory subDirectory: String = "json-data.bundle") -> Data? {
		guard let path = path(forResource: filename, ofType: fileExtension,
							  inDirectory: subDirectory) else {
								return nil
		}
		if let ret = try? Data(contentsOf: URL(fileURLWithPath: path)) {
			return ret
		}
		return nil
	}
}

class MockSession: URLSessionProtocol {
	
	private (set) var lastURL: URL?
	
	var nextError: Error?
	var nextData: Data?
	var nextDataTask: URLSessionDataTaskProtocol?
	
	func dataTask(request: URLRequest,
				  completionHandler: @escaping URLSession.DataTaskResult) -> URLSessionDataTaskProtocol {
		
		lastURL = request.url
		
		let successResponse = URLResponse(url: request.url!,
										  mimeType: nil,
										  expectedContentLength: 0,
										  textEncodingName: nil)
		completionHandler(nextData, successResponse, nextError)
		
		return nextDataTask ?? MockURLSessionDataTask()
	}
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
	
	private (set) var resumeWasCalled = false
	
	func resume() { resumeWasCalled = true }
}


//extension Location {
//	static func withId(_ id: Int, name: String) -> Location {
//		return Location(id: id, name: name, mapSection: [:])
//	}
//}
//
//extension Vehicle {
//	static func withId(_ id: Int, model: String) -> Vehicle {
//		return Vehicle(id: id, vin: "", numberPlate: "",
//					   position: .init(latitude: 0, longitude: 0),
//					   fuel: 0, model: model)
//	}
//}
