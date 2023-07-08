//
//  Double+extensions.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 02.07.23.
//

import Foundation

extension Double {
    
    var formatDecimal: String {
        return String(format: "%.01f", self)
    }
    
    var format2Decimals: String {
        return String(format: "%.02f", self)
    }
}
