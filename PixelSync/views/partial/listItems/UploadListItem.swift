//
//  UploadListItem.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import SwiftUI
import PixeldrainSwift

struct UploadListItem: View {
    @ObservedObject var transfer: UploadTransfer
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(transfer.source.lastPathComponent).bold().lineLimit(1).truncationMode(.tail).help(transfer.source.absoluteString)
                ProgressView(value: transfer.progress).progressViewStyle(.linear)
                Text("\(formatFileSize(UInt(transfer.lastUpdateBytes)))/\(formatFileSize(UInt(transfer.totalBytes))) (\(formatFileSize(transfer.bytesPerSecond))/s)")
            }
        }
    }
}
