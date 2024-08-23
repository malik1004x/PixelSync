//
//  ContentView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 29/07/2024.
//

import SwiftUI
import PixeldrainSwift

struct ContentView: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State var loginSheetDisplayed: Bool = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FilesView(apiConnection: $apiConnection, transferManager: transferManager)
                .tabItem {
                    Text("Files")
                }.tag(0)
            ListsView(apiConnection: $apiConnection, transferManager: transferManager)
                .tabItem {
                    Text("Lists")
                }.tag(1)
            TransfersView(apiConnection: $apiConnection, transferManager: transferManager)
                .tabItem {
                    Text("Transfers")
                }.tag(2)
            ProfileView(apiConnection: $apiConnection, transferManager: transferManager)
                .tabItem {
                    Text("Profile")
                }.tag(3)
        }.padding().frame(minWidth: 400, minHeight: 500)
    }
}
