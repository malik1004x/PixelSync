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
    @State private var searchQuery: String = ""
    
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
                VStack {
                    HStack {
                        TextField("Search", text: $searchQuery).cornerRadius(15).padding(.horizontal, 15)
                    }.padding(.top, 15)
                    List (fileList!.filter {file in
                        searchQuery.isEmpty || file.name.lowercased().contains(searchQuery.lowercased())
                    }, id: \.id) { file in
                        FileListItem(transferManager: transferManager, fileInfo: file).padding(.horizontal, 10)
                    }
                }
            }
        }
    }
}
