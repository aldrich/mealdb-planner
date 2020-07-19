//
//  RocketDataSetup.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import Foundation
import PINCache

protocol PersistenceProtocol {
	
	func getObjectForKey<T: Cacheable>(_ key: String) -> T?
	
	func setObject<T: Cacheable>(_ object: T)
}

class Persistence: PersistenceProtocol {
	
	enum Constants {
		static var pinCacheDiskAgeLimit = TimeInterval(60 * 60 * 24)
	}
	
	let pinCache: PINCache = getPinCache()
	
	func getObjectForKey<T: Cacheable>(_ key: String) -> T?  {
		if let object = pinCache.object(forKey: key) as? [AnyHashable: Any],
			let decoded = object.decoded(to: T.self) {
			return decoded
		}
		return nil
	}
	
	func setObject<T: Cacheable>(_ object: T) {
		DispatchQueue.global(qos: .background).async {
			let key = object.key
			let encoded = object.encodedDict
			self.pinCache.setObject(encoded as NSCoding, forKey: key)
		}
	}
}

extension Persistence {
	
	static func getPinCache() -> PINCache {
		let cacheName = isRunningInUnitTest ? "unit-test-cache" : "co.aldrich.cache"
		let ret = PINCache(name: cacheName)
		
		ret.diskCache.ageLimit = Constants.pinCacheDiskAgeLimit
		
//		#if DEBUG
//		ret.diskCache.didAddObjectBlock = { mockCache, key, object, url in
//			print("PINCache: added to disk cache object with key \(key)")
//		}
//
//		ret.diskCache.didRemoveObjectBlock = { mockCache, key, object, url in
//			print("PINCache: removed from disk cache object with key \(key)")
//		}
//
//		ret.memoryCache.didRemoveAllObjectsBlock = { _ in
//			print("PINCache: removing all objects from memory cache")
//		}
//		#endif
		
		return ret
	}
	
	static var isRunningInUnitTest: Bool {
		#if DEBUG
		if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
			return true
		}
		#endif
		return false
	}
}
