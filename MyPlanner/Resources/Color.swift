//
//  Color.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//
import UIKit

public struct Color {
    
    // MARK: - Properties
    public static let accentColor = UIColor(named: "AccentColor")!
    public static let background = UIColor.white
    public static let buttonNotSelected = UIColor.gray
    public static let buttonSelected = UIColor.black
    public static let black = UIColor.black
    public static let dateSelected = UIColor.white
    public static let sunday = UIColor(0xEA4747)
    public static let saturday = UIColor(0x5282E0)
    
    // MARK: - Methods
    public static func getColorAssets() -> [String] {
        var colorAssets = [String]()
        var index = 1
        
        while let color = UIColor(named: "\(index)") {
            colorAssets.append(color.toHexStr())
            index += 1
        }
        
        return colorAssets
    }
}
