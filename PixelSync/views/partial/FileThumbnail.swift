//
//  FileThumbnail.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/22/24.
//

import SwiftUI
import PixeldrainSwift

struct FileThumbnail: View {
    let fileInfo: PixeldrainFileInfo
    
    var body: some View {
        AsyncImage(url: URL(string: "https://pixeldrain.com/api\(fileInfo.thumbnailHref)")) { phase in
            if let image = phase.image {
                image.resizable().scaledToFit()
            } else if phase.error != nil {
                Image(systemName: "questionmark.folder.fill").onAppear() {
                    print(phase.error!)
                }
            } else {
                ProgressView().progressViewStyle(.circular)
            }
        }.frame(maxWidth: 50)
    }
}
