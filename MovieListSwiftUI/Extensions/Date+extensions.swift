//
//  Date+extensions.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 26.06.23.
//

import Foundation
import SwiftUI

extension Date {
    static func today() -> Date {
        return Date()
    }
}

extension Date {
    func dateToString(with format: String?, _ timezone: String? = "UTC") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "dd MMMM YYYY 'в' HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func dateToTimeInterval() -> Double {
        return self.timeIntervalSince1970
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension String {
    var stringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
}
