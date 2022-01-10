//
//  ColorSelectorDataSource.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/10.
//

import Foundation

protocol ColorSelectorDataSource: AnyObject {
    
    func setInitialColor() -> Plan.Color
}
