//
//  DownloadListItem.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/22/24.
//

import SwiftUI
import PixeldrainSwift

struct DownloadListItem: View {
    @ObservedObject var transfer: DownloadTransfer
    
    var body: some View {
        HStack{
            FileThumbnail(fileInfo: transfer.fileInfo)
            VStack(alignment: .leading) {
                Text(transfer.fileInfo.name).bold().lineLimit(1).truncationMode(.tail).help(transfer.fileInfo.name)
                ProgressView(value: transfer.progress).progressViewStyle(.linear)
                Text("\(formatFileSize(UInt(transfer.lastUpdateBytes)))/\(formatFileSize(transfer.fileInfo.size)) (\(formatFileSize(transfer.bytesPerSecond))/s)")
            }
        }
    }
}
