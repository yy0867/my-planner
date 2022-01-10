//
//  DateSelectorDelegate.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/04.
//

import Foundation

protocol DateSelectorDelegate: AnyObject {
    
    func dateSelector(_ dateSelector: DateSelector, selectedDate: Date)
}
