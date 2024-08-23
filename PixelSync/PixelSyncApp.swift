//
//  PixelSyncApp.swift
//  PixelSync
//
//  Created by Robert Malikowski on 29/07/2024.
//

import SwiftUI
import PixeldrainSwift

@main
struct PixelSyncApp: App {
    @State private var apiConnection: PixeldrainAPI? = nil
    @ObservedObject private var transferManager: TransferManager = TransferManager()
    
    var body: some Scene {
        MenuBarExtra {
            ContentView(apiConnection: $apiConnection, transferManager: transferManager)
        } label: {
            let image: NSImage = {
                $0.size.height = 18
                $0.size.width = 18
                return $0
            }(NSImage(named: "pixeldrain")!)
            
            Image(nsImage: image)
        }.menuBarExtraStyle(.window)
    }
}
