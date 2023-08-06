//
//  Utils.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        return Path(path.cgPath)
    }
}
