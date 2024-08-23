//
//  FileListItem.swift
//  PixelSync
//
//  Created by Robert Malikowski on 11/8/24.
//

import SwiftUI
import PixeldrainSwift

struct FileListItem: View {
    @ObservedObject var transferManager: TransferManager
    let fileInfo: PixeldrainFileInfo
    var body: some View {
        HStack{
            FileThumbnail(fileInfo: fileInfo)
            VStack(alignment: .leading) {
                Text(fileInfo.name).bold().lineLimit(1).truncationMode(.tail).help(fileInfo.name)
                Text(getFileTypeDescription(fileInfo.mimeType)).lineLimit(1).truncationMode(.tail).help(fileInfo.mimeType)
                HStack {
                    Text(formatFileSize(fileInfo.size)).fontWeight(.light).help("\(fileInfo.size) bytes")
                    Divider()
                    Text(formatTimeInterval(Int(Date.now.timeIntervalSince(fileInfo.dateUpload)))).fontWeight(.light).help(fileInfo.dateUpload.ISO8601Format())
                }
                
            }
            Spacer()
            Button(action: {transferManager.startDownload(fileInfo: fileInfo, destination: FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0])})
            {
                Image(systemName: "arrow.down.circle")
            }.buttonStyle(.borderless)
        }
    }
}
