//
//  TransfersView.swift
//  PixelSync
//
//  Created by Robert Malikowski on 11/8/24.
//

import SwiftUI
import PixeldrainSwift

struct TransfersView: View {
    @Binding var apiConnection: PixeldrainAPI?
    @ObservedObject var transferManager: TransferManager
    @State private var showFileImporter = false
    
    var body: some View {
        if apiConnection == nil {
            LoginBanner(apiConnection: $apiConnection, transferManager: transferManager)
        } else {
            ScrollView {
                Button(action: {showFileImporter = true}) {
                    Text("Upload file")
                }
                ForEach(Array(transferManager.transfers.values), id: \.task.taskIdentifier) {
                    transfer in
                    if let downloadItem = transfer as? DownloadTransfer {
                        DownloadListItem(transfer: downloadItem)
                    } else if let uploadItem = transfer as? UploadTransfer {
                        UploadListItem(transfer: uploadItem)
                    }
                    Divider()
                }.padding(.horizontal, 20)
            }.fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.item],  allowsMultipleSelection: true) { result in
                switch result {
                case .success(let files):
                    files.forEach { file in
                        let gotAccess = file.startAccessingSecurityScopedResource()
                        if gotAccess {
                            transferManager.startUpload(source: file)
                        }
                    }
                case .failure:
                    print("file load error")
                }
            }
        }
    }
}
