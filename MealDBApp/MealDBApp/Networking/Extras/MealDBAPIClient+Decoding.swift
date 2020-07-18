//
//  MealDBAPIClient+Decoding.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

extension MealDBAPIClient {
	// decode the response and pass back up any error message in a nice
	// format
	func decodeResponse<T>(data: Data?, error: Error?, to type: T.Type,
						   completion: @escaping (T?, String?) -> Void) where T: Decodable {
		guard error == nil else {
			completion(nil, error!.localizedDescription)
			return
		}
		guard let data = data, data.count > 0 else {
			completion(nil, "Empty data.")
			return
		}
		do {
			let decoded = try data.decoded(as: T.self)
			completion(decoded, nil)
		} catch {
			if let decodingError = error as? DecodingError {
				completion(nil, decodingError.prettyDesc)
			} else {
				completion(nil, error.localizedDescription)
			}
		}
	}
	
	func download(url: URL, completion: @escaping (Data?, Error?) -> Void) {
		let request = URLRequest(url: url)
		let task = session.dataTask(request: request) { data, response, error in
			DispatchQueue.main.async {
				completion(data, error)
			}
		}
		task.resume()
	}

}
