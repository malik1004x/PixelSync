//
//  ProfileUtilityButtons.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import SwiftUI
import PixeldrainSwift

struct ProfileUtilityButtons: View {
    @Binding var apiConnection: PixeldrainAPI?
    @State var aboutPopoverDisplayed: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {}) {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }.buttonStyle(.link)
            Button(action: {NSApplication.shared.terminate(nil)}) {
                VStack {
                    Image(systemName: "xmark")
                    Text("Quit")
                }
            }.buttonStyle(.link)
            Button(action: {apiConnection = nil}) {
                VStack {
                    Image(systemName: "person.crop.circle.badge.xmark")
                    Text("Logout")
                }
            }.buttonStyle(.link)
            Button(action: {aboutPopoverDisplayed = true}) {
                VStack {
                    Image(systemName: "info.circle")
                    Text("About")
                }
            }.buttonStyle(.link).popover(isPresented: $aboutPopoverDisplayed) {
                AboutPopover(aboutPopoverDisplayed: $aboutPopoverDisplayed)
            }
        }
    }
}
