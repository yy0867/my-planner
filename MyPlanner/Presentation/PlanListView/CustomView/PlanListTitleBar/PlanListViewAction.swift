//
//  PlanListViewModelAction.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/04.
//

import Foundation

public enum PlanListViewAction {
    
    case profile
    case dateSelector
    case addPlan
    case editPlan(index: Int)
    case searchPlan
    case reloadData
}
