//
//  Utils.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import Foundation

func mainThread(_ completion: SimpleCompletion) {
    DispatchQueue.main.async {
        completion?()
    }
}

func mainThreadAfter(_ deadline: Double, _ completion: SimpleCompletion) {
    DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
        completion?()
    }
}

typealias SimpleCompletion = (() -> Void)?

public func print(_ items: String...,
                  filename: String = #file,
                  function : String = #function,
                  line: Int = #line,
                  separator: String = " ",
                  terminator: String = "\n") {
#if DEBUG
    let pretty = "\(URL(fileURLWithPath: filename).lastPathComponent) [#\(line)] \(function)\n\t-> "
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(pretty+output, terminator: terminator)
#else
    Swift.print("RELEASE MODE")
#endif
}
