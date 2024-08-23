//
//  AboutPopover.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import SwiftUI

struct AboutPopover: View {
    @Binding var aboutPopoverDisplayed: Bool
    @FocusState private var isFocused: Bool
    static let easterEggString = "gibcow"
    @State var easterEggStringOffset = 0
    @State var easterEggDisplayed: Bool = false
    
    var body: some View {
        if easterEggDisplayed {
            Text("You found my cow.").font(.title2)
            Image(nsImage: NSImage(named: "cow")!).resizable().scaledToFit().frame(maxWidth: 300)
        } else {
            VStack{
                HStack {
                    Image(nsImage: NSImage(named: "PixelSync")!)
                    VStack {
                        Text(Bundle.main.infoDictionary!["CFBundleName"] as! String).font(.title)
                        Text("version \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")
                    }
                }.padding(.horizontal, 30)
                Spacer().frame(width: 20)
                Text("App by Robert \"Malik\" Malikowski")
                Text("Made in Poland 🇵🇱")
                Spacer().frame(width: 20)
                if #available(macOS 14.0, *) {
                    Text("").focusable().focused($isFocused).onAppear(){isFocused = true}.onKeyPress {press in
                        if press.characters.first == AboutPopover.easterEggString[AboutPopover.easterEggString.index(AboutPopover.easterEggString.startIndex, offsetBy: easterEggStringOffset)] {
                            easterEggStringOffset += 1
                            if easterEggStringOffset == AboutPopover.easterEggString.count {
                                easterEggDisplayed = true
                            }
                        } else {
                            easterEggStringOffset = 0
                        }
                        return .handled
                    }
                }
            }.padding(.top, 15)
        }
        }
}
