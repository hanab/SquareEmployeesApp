//
//  APINetworkTest.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
import XCTest

@testable import SquareEmployeesApp

class APINetworkTests: XCTestCase {
    
    //MARK: Properties
    var empoyeesGetway: GateWayProtocol?
    var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        empoyeesGetway = EmployeesAPIGateway(session: session)
    }
    
    //MARK: TestCases
    func testDataTaskResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        empoyeesGetway?.fetchAllEmployees(url: url) { (employees) in
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testDataTaskUrlSet() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        
        empoyeesGetway?.fetchAllEmployees(url: url) { (employees) in
        }
        XCTAssert((session.mockURL == url))
    }
}
