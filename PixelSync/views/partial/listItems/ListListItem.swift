//
//  ListListItem.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import SwiftUI
import PixeldrainSwift

struct ListListItem: View {
    let listInfo: PixeldrainListInfo
    @State var completeListInfo: PixeldrainListInfo?
    @State var isExpanded: Bool = false
    @ObservedObject var transferManager: TransferManager
    @Binding var apiConnection: PixeldrainAPI?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {isExpanded.toggle()}) {
                    if !isExpanded {
                        Image(systemName: "chevron.right")
                    } else if completeListInfo == nil {
                        ProgressView().progressViewStyle(.circular).onAppear() {
                            Task {
                                completeListInfo = try await transferManager.apiConnection?.getListInfo(listId: listInfo.id)
                            }
                        }
                    } else {
                        Image(systemName: "chevron.down")
                    }
                }.buttonStyle(.borderless).scaledToFit().frame(width: 10)
                VStack {
                    HStack {
                        Text(listInfo.title).fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("\(formatTimeInterval(Int(Date.now.timeIntervalSince(listInfo.dateCreated))))")
                        Divider()
                        Text("\(listInfo.fileCount) files")
                        Spacer()
                    }
                }
                Spacer()
            }
            if isExpanded && completeListInfo != nil {
                ForEach(completeListInfo!.files!, id: \.id) { file in
                    HStack {
                        Spacer().frame(width: 20)
                        FileListItem(transferManager: transferManager, fileInfo: file)
                    }

                }
            }
        }

    }
}
