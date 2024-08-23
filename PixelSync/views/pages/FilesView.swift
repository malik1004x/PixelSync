//
//  FilesView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 6/8/24.
//

import SwiftUI
import PixeldrainSwift

struct FilesView: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State private var fileList: [PixeldrainFileInfo]?
    
    var body: some View {
        if apiConnection == nil {
            LoginBanner(apiConnection: $apiConnection, transferManager: transferManager)
        } else {
            if fileList == nil {
                ProgressView().onAppear() {
                    Task {
                        fileList = try await apiConnection!.getUserFiles()
                    }
                }
            } else {
                ScrollView {
                    ForEach(fileList!, id: \.id) { file in
                        FileListItem(transferManager: transferManager, fileInfo: file)
                        Divider()
                    }
                }
            }
        }
    }
}
