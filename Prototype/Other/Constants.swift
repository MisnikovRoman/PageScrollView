//
//  Constants.swift
//  Prototype
//
//  Created by MisnikovRoman on 20/01/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

enum CC {
    enum Colors {
        static let red    = createColor(r: 232, g: 143, b: 118, a: 255)
        static let blue   = createColor(r: 184, g: 219, b: 217, a: 255)
        static let green  = createColor(r: 220, g: 223, b: 105, a: 255)
        static let orange = createColor(r: 239, g: 192, b: 065, a: 255)
    }
}

private func createColor(r: Int, g: Int, b: Int, a: Int) -> UIColor {
    return UIColor(
        red:     CGFloat(r) / 255,
        green:   CGFloat(g) / 255,
        blue:    CGFloat(b) / 255,
        alpha:   CGFloat(a) / 255
    )
}
