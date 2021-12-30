//
//  ResponseLog.swift
//  MyPlannerTests
//
//  Created by 김세영 on 2021/12/30.
//

import Foundation
import XCTest
@testable import MyPlanner

extension XCTestCase {

    func arrayLog(_ response: [Any]?) {
        
        guard let response = response else {
            print("#### response is nil. ####")
            return
        }
        
        print()
        print("#### response is ####")
        for r in response {
            print(r)
        }
        print("#### end ####")
        print()
    }
    
    func log(_ response: Any?) {
        
        guard let response = response else {
            print("#### response is nil. ####")
            return
        }
        
        print()
        print("#### response is ####")
        print(response)
        print("#### end ####")
        print()
    }
}
