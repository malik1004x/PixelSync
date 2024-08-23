//
//  DownloadTransfer.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/22/24.
//
import PixeldrainSwift
import Foundation

class DownloadTransfer: Transfer, ObservableObject {
    let fileInfo: PixeldrainFileInfo
    var task: URLSessionTask
    var destination: URL
    var lastUpdateTime: Date
    var lastUpdateBytes: Int64
    @Published var bytesPerSecond: UInt
    @Published var progress: Double
    @Published var complete: Bool
    
    init(fileInfo: PixeldrainFileInfo, destination: URL, apiConnection: PixeldrainAPI) {
        self.fileInfo = fileInfo
        self.destination = destination
        self.task = apiConnection.downloadFile(fileId: fileInfo.id)
        self.lastUpdateTime = .distantPast
        self.lastUpdateBytes = 0
        self.bytesPerSecond = 0
        self.progress = 0
        self.complete = false
    }
    
    func handleCompletion() {
        DispatchQueue.main.async {
            self.complete = true
        }
    }
}
