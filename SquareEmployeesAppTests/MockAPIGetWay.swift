//
//  MockAPIGateWay.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SquareEmployeesApp

class MockAPIGetway: GateWayProtocol {
    
    //MARK: properties
    var fetchEmployeesCalled = false
    var fetchEmployeesCalledWithCompletion: ((EmployeesResult) -> Void)?
    
    //MARK: Methods
    func fetchAllEmployees( completion: @escaping (EmployeesResult) -> Void) {
        fetchEmployeesCalledWithCompletion = completion
        fetchEmployeesCalled = true
    }
    
    func fetchAllEmployees(url: URL, completion: @escaping (EmployeesResult) -> Void) {
        fetchEmployeesCalledWithCompletion = completion
        fetchEmployeesCalled = true
    }
}
