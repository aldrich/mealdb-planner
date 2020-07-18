//
//  Dictionary+Codable.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation

public extension Encodable {
	var encodedDict: [AnyHashable: Any] {
		guard let encoded = try? DictionaryEncoder().encode(self),
			let ret = encoded as? [AnyHashable: Any] else {
				return [:]
		}
		return ret
	}
}

extension Dictionary {
	func decoded<T>(to type: T.Type) -> T? where T: Decodable {
		guard let val = try? DictionaryDecoder.decode(type, from: self) else {
			return nil
		}
		return val
	}
}

class DictionaryEncoder {
	
	/// Encodes given Encodable value into an array or dictionary
	func encode<T>(_ value: T) throws -> Any where T: Encodable {
		let jsonData = try JSONEncoder().encode(value)
		return try JSONSerialization
			.jsonObject(with: jsonData, options: .allowFragments)
	}
}

public enum DictionaryDecoder {
	
	/// Decodes given Decodable type from given array or dictionary
	public static func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
		let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
		var ret: T!
		do {
			ret = try JSONDecoder().decode(type, from: jsonData)
		} catch {
			let errStr = String(format: "Error decoding \(type) with reason: %@",
				error.decodingErrorDescription)
			print(errStr)
			throw error
		}
		return ret
	}
}

extension Error {
	
	var decodingErrorDescription: String {
		guard let error = self as? DecodingError else {
			return self.localizedDescription
		}
		if case let .keyNotFound(_, ctx) = error {
			return ctx.debugDescription
		} else if case let .dataCorrupted(ctx) = error {
			return ctx.debugDescription
		} else if case let DecodingError.typeMismatch(_, ctx) = error {
			return ctx.debugDescription
		} else if case let DecodingError.valueNotFound(_, ctx) = error {
			return ctx.debugDescription
		} else {
			return "Unknown decoding error"
		}
	}
}
