//
//  ViewModelTest.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SquareEmployeesApp
import XCTest

class ViewModelTest: XCTestCase {
    
    //MARK: properties
    var subject: EmployeesViewModel!
    var apiDelegate: MockAPIGetway!
    
    
    override func setUp() {
        super.setUp()
        apiDelegate = MockAPIGetway()
        subject = EmployeesViewModel(gateWay: apiDelegate)
        subject.fetchData{}
    }
    
    //MARK: Testcases
    func testFetchDataCalled() {
        XCTAssertTrue(apiDelegate.fetchEmployeesCalled)
    }
    
    func testInvalidJsonData() {
        apiDelegate.fetchEmployeesCalledWithCompletion?(EmployeesResult.Failure(NetworkError.InvalidJSONData))
        XCTAssertEqual(subject.getNetworkError()?.rawValue, "The Json is not valid")
    }
    
    func testValidResponse() {
        let employees = Employees(employees: [Employee(uuid: "245566", fullName: "Hana Demas", phoneNumber: "12344567", emailAddress: "fgfgfd@gmail.com", biography: "I work at the sells team", photoURLSmall: "http://shoturl.png", photoURLLarge: "http://longurl.png", team: "sells", employeeType: .fullTime)])
        
        apiDelegate.fetchEmployeesCalledWithCompletion?(EmployeesResult.Success(employees))
        XCTAssertEqual(subject.getNumberOfEmployees(), 1)
        XCTAssertEqual(subject.getEmployeeAtIndex(index: 0)?.fullName, "Hana Demas")
    }
}
