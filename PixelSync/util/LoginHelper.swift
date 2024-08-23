//
//  LoginHelper.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import PixeldrainSwift

class LoginHelper {
    static func login(apiKey: String, apiConnection: inout PixeldrainAPI?, transferManager: TransferManager) {
        apiConnection = PixeldrainAPI(apiKey: apiKey, delegate: transferManager)
        transferManager.addApiConnection(apiConnection: apiConnection!)
        KeyStorage.storeKey(apiKey)
    }
    
    static func logout(apiConnection: inout PixeldrainAPI?) {
        apiConnection = nil
        KeyStorage.removeKey()
    }
}
