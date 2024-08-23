//
//  KeyStorage.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import Foundation

class KeyStorage {
    static func storeKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: .localizedStringWithFormat("%@.key", Bundle.main.bundleIdentifier!))
    }
    
    static func getKey() -> String? {
        return UserDefaults.standard.string(forKey: .localizedStringWithFormat("%@.key", Bundle.main.bundleIdentifier!))
    }
    
    static func removeKey() {
        UserDefaults.standard.removeObject(forKey: .localizedStringWithFormat("%@.key", Bundle.main.bundleIdentifier!))
    }
}
