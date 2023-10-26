//
//  DateFormatters.swift
//  DateFixer
//
//  Created by Tom Hartnett on 10/25/23.
//

import Foundation

extension DateFormatter {
    static var iso8601Formatter: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()

    static var mediumDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
