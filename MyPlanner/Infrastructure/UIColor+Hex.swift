//
//  UIColor+Hex.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import UIKit

extension UIColor {
    
    // MARK: - Methods
    public convenience init(_ hex: Int) {
        assert(
            0...0xFFFFFF ~= hex,
            "extension UIColor -> hex should be #000000 ~ #FFFFFF"
        )
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)
        self.init(red: red, green: green, blue: blue)
    }
    
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha:  1.0
        )
    }
}
