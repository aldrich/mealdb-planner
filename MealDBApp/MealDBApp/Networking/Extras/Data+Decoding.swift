//
//  Data+Decoding.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

extension Data {
	func decoded<T>(as type: T.Type) throws -> T? where T: Decodable {
		let decoder = JSONDecoder()
		return try decoder.decode(type.self, from: self)
	}
}

extension DecodingError.Context {
	var path: String {
		return codingPath.map { $0.pathComponent }.joined(separator: " » ")
	}
}

extension DecodingError {
	
	var prettyDesc: String {
		var desc = localizedDescription
		switch self {
		case let .dataCorrupted(ctx):
			desc = String(format: "Data corrupted at [%@]", ctx.path)
		case let .keyNotFound(key, ctx):
			desc = String(format: "No key '%@' found at [%@]", key.pathComponent, ctx.path)
		case let .typeMismatch(type, ctx):
			desc = String(format: "Type '%@' doesn't match expected at [%@]", String(describing: type), ctx.path)
		case let .valueNotFound(type, ctx):
			desc = String(format: "Value not found for %@ at [%@]", String(describing: type), ctx.path)
		default:
			break
		}		
		return desc
	}
}

extension CodingKey {
	var pathComponent: String {
		guard let intValue = intValue else {
			return stringValue
		}
		return "\(intValue)"
	}
}
