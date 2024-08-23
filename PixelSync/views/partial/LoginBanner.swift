//
//  LoginBanner.swift
//  PixelSync
//
//  Created by Robert Malikowski on 6/8/24.
//

import SwiftUI
import PixeldrainSwift

struct LoginBanner: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State var showLoginPopover: Bool = false
    
    var body: some View {
        VStack {
            Text("You are not logged in.")
            Button(action: {
                showLoginPopover = true
            }) {
                HStack {
                    Image("pixeldrain").resizable().scaledToFit()
                    Text("Sign in with Pixeldrain")
                }
            }.popover(isPresented: $showLoginPopover, content: {LoginView(apiConnection: $apiConnection, transferManager: transferManager)})
        }
    }
}
