//
//  LoginView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 30/07/2024.
//

import SwiftUI
import PixeldrainSwift

struct LoginView: View {
    @State private var apiKeyString: String = ""
    @State private var bottomText: String = "Don't have an API key? [Get one](https://pixeldrain.com/user/api_keys)"
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    
    var body: some View {
        VStack {
            Image("pixeldrain_banner_logo").resizable().scaledToFit().padding()
            TextField("Paste API key...", text: $apiKeyString).padding().onSubmit {
                let pattern = /[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}/
                do {
                    if (try pattern.firstMatch(in: apiKeyString)) != nil {
                        apiConnection = PixeldrainAPI(apiKey: apiKeyString, delegate: transferManager)
                        transferManager.addApiConnection(apiConnection: apiConnection!)
                    } else {
                        bottomText = "That's not a correct API key."
                    }
                } catch {
                    return
                }
            }
            Text(.init(bottomText)).padding()
        }.padding().frame(maxWidth: 300, maxHeight: 300)
    }
}
