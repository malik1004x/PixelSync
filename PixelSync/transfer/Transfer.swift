//
//  Transfer.swift
//  PixelSync
//
//  Created by Robert Malikowski on 8/21/24.
//
import Foundation
import PixeldrainSwift

protocol Transfer: ObservableObject {
    var task: URLSessionTask {get set}
    var lastUpdateTime: Date {get set}
    var lastUpdateBytes: Int64 {get set}
    var bytesPerSecond: UInt {get set}
    var progress: Double {get set}
    var complete: Bool {get set}
    func handleCompletion()
}
