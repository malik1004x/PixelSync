//
//  TransferManager.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/21/24.
//
import Foundation
import PixeldrainSwift

class TransferManager: NSObject, URLSessionTaskDelegate, URLSessionDownloadDelegate, URLSessionDataDelegate, ObservableObject {
    
    // the key of the dictionary is the .taskIdentifier of the URLSessionTask object.
    @Published var transfers: Dictionary<Int, any Transfer>
    var apiConnection: PixeldrainAPI?
    
    init(apiConnection: PixeldrainAPI?=nil) {
        transfers = [:]
        self.apiConnection = apiConnection
    }
    
    func addApiConnection(apiConnection: PixeldrainAPI) {
        self.apiConnection = apiConnection
    }
    
    func startDownload(fileInfo: PixeldrainFileInfo, destination: URL) {
        let newTransfer = DownloadTransfer(fileInfo: fileInfo, destination: destination, apiConnection: apiConnection!)
        transfers[newTransfer.task.taskIdentifier] = newTransfer
    }
    
    func startUpload(source: URL) {
        let newTransfer = UploadTransfer(source: source, apiConnection: apiConnection!)
        transfers[newTransfer.task.taskIdentifier] = newTransfer
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let transfer = transfers[downloadTask.taskIdentifier] else {
            print("refresh from urlsession that's not in a valid transfer. how did we get here?")
            return
        }
        
        let timeSinceLastUpdate = Date().timeIntervalSince(transfer.lastUpdateTime)
        let bytesSinceLastUpdate = totalBytesWritten - transfer.lastUpdateBytes
        
        DispatchQueue.main.async {
            if timeSinceLastUpdate != 0 {
                transfer.bytesPerSecond = UInt(Float(bytesSinceLastUpdate) / Float(timeSinceLastUpdate))
            }
            transfer.lastUpdateTime = Date()
            transfer.lastUpdateBytes = totalBytesWritten
            transfer.progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        guard let transfer = transfers[task.taskIdentifier] else {
            print(".....the transfer that completed doesn't exist???? what?")
            return
        }
        transfer.handleCompletion()
        //TODO copy the file from location to transfer.destination
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let transfer = transfers[task.taskIdentifier] else {
            print("refresh from urlsession that's not in a valid transfer. how did we get here?")
            return
        }
        
        let timeSinceLastUpdate = Date().timeIntervalSince(transfer.lastUpdateTime)
        let bytesSinceLastUpdate = totalBytesSent - transfer.lastUpdateBytes
        
        DispatchQueue.main.async {
            if timeSinceLastUpdate != 0 {
                transfer.bytesPerSecond = UInt(Float(bytesSinceLastUpdate) / Float(timeSinceLastUpdate))
            }
            transfer.lastUpdateTime = Date()
            transfer.lastUpdateBytes = totalBytesSent
            transfer.progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
            if let uploadTransfer = transfer as? UploadTransfer {
                uploadTransfer.totalBytes = totalBytesExpectedToSend
            }
        }
    }
}
