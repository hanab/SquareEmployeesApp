//
//  DataParsingTest.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
import XCTest
@testable import SquareEmployeesApp

class DataParsingTest: XCTestCase {
    
    //MARK: Properties
    var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }
    
    //MARK: TestCases
    func testInitJSONValidJSON() {
        let jsonData = JSonParsingHelper.data(forJson: "valid_employees")
        let employees = try! decoder.decode(Employees.self, from: jsonData!)
        let emp = employees.employees[0]
        XCTAssertEqual(11, employees.employees.count)
        XCTAssertEqual(emp.fullName,  "Justine Mason")
    }
    
    func testInitJSONMissingKeys() {
        guard let jsonData = JSonParsingHelper.data(forJson: "invalid_employees_missing_keys") else { return }
        XCTAssertThrowsError(try decoder.decode(Employees.self, from: jsonData))
    }
    
    func testInitJSONEmpty() {
        guard let jsonData = JSonParsingHelper.data(forJson: "empty") else { return }
        
        let employees = try! decoder.decode(Employees.self, from: jsonData)
        XCTAssertEqual(0, employees.employees.count)
    }
    
    func testInitalizer() {
        let subject = Employee(uuid: "245566", fullName: "Hana Demas", phoneNumber: "12344567", emailAddress: "fgfgfd@gmail.com", biography: "I work at the sells team", photoURLSmall: "http://shoturl.png", photoURLLarge: "http://longurl.png", team: "sells", employeeType: .fullTime)
        
        XCTAssertEqual(subject.fullName, "Hana Demas")
        XCTAssertEqual(subject.phoneNumber, "12344567")
        XCTAssertEqual(subject.biography, "I work at the sells team")
        XCTAssertEqual(subject.photoURLSmall, "http://shoturl.png")
    }
}
