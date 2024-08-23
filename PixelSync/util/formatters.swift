//
//  formatters.swift
//  PixelSync
//
//  Created by Robert Malikowski on 11/8/24.
//

import UniformTypeIdentifiers


func formatFileSize(_ bytes: UInt) -> String {
    let units = ["bytes", "kB", "MB", "GB", "TB"]
    var size = Double(bytes)
    var unitIndex = 0

    while size >= 1000 && unitIndex < units.count - 1 {
        size /= 1000
        unitIndex += 1
    }

    return String(format: "%.2f %@", size, units[unitIndex])
}

func formatTimeInterval(_ interval: Int) -> String {
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 365 * day
        
        if interval < minute {
            return "\(interval)s"
        } else if interval < hour {
            return "\(interval / minute)m"
        } else if interval < day {
            return "\(interval / hour)h"
        } else if interval < week {
            return "\(interval / day)d"
        } else if interval < month {
            return "\(interval / week)w"
        } else if interval < year  {
            return "\(interval/month)mo"
        } else {
            return "\(interval/year)y"
        }
}

func formatBalanceMicroEur(balanceMicroEur: UInt) -> String {
    return "€" + String(format: "%.2f", Double(balanceMicroEur) / 1000000)
}

func getFileTypeDescription(_ mimeType: String) -> String {
    if let type = UTType(mimeType: mimeType) {
        if let description = type.localizedDescription {
            return description
        }
    }
    return mimeType
}
