//
//  ColorSelectorDelegate.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/10.
//

import Foundation

protocol ColorSelectorDelegate: AnyObject {
    
    func colorSelector(didSelectColor selectedColor: Plan.Color)
}
