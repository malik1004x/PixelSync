//
//  UploadTransfer.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/23/24.
//

import PixeldrainSwift
import Foundation

class UploadTransfer: Transfer, ObservableObject {
    var source: URL
    var task: URLSessionTask
    var lastUpdateTime: Date
    var lastUpdateBytes: Int64
    var totalBytes: Int64
    @Published var bytesPerSecond: UInt
    @Published var progress: Double
    @Published var complete: Bool
    
    init(source: URL, apiConnection: PixeldrainAPI) {
        self.task = apiConnection.uploadFile(source: source)
        self.source = source
        self.lastUpdateTime = .distantPast
        self.lastUpdateBytes = 0
        self.bytesPerSecond = 0
        self.progress = 0
        self.complete = false
        self.totalBytes = 0
    }
    
    func handleCompletion() {
        DispatchQueue.main.async {
            self.complete = true
        }
        self.source.stopAccessingSecurityScopedResource()
    }
}
