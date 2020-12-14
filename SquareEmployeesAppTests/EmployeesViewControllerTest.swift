//
//  EmployeesViewControllerTest.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/12/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SquareEmployeesApp
import XCTest

class EmployeesViewControllerTest: XCTestCase {
    
    //MARK: properites
    var subject: EmployeesViewController!
    var alertPresenter: MockedAlertPresenter!
    var apiDelegate: MockAPIGetway!
    var viewModel: EmployeesViewModel!
    
    override func setUp() {
        super.setUp()
        alertPresenter = MockedAlertPresenter()
        apiDelegate = MockAPIGetway()
        viewModel = EmployeesViewModel(gateWay: apiDelegate)
        subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "list") as? EmployeesViewController
        
        subject.alertPresenter = alertPresenter
        subject.employeeViewModel = viewModel
        subject.loadFromNewtork()
        XCTAssertNotNil(subject.view)
    }
    
    //MARK: TestCases
    func testViewsAreLoaded() {
        XCTAssertNotNil(subject.employeesTableView)
        XCTAssertNotNil(subject.refreshControl)
        XCTAssertNotNil(subject.loadingIndicator)
    }
    
    func testNavigationTitleSet(){
        XCTAssertEqual(subject.navigationItem.title, "Employees")
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(subject.employeesTableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(subject.employeesTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(subject.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(subject.responds(to: #selector(subject.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(subject.responds(to: #selector(subject.tableView(_:cellForRowAt:))))
    }
    
    func testAlertDisplayed() {
        let exp = expectation(description: "Alert Expectation")
        
        apiDelegate.fetchEmployeesCalledWithCompletion?(EmployeesResult.Failure(NetworkError.InvalidJSONData))
        
        subject.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.alertPresenter.presentWasCalled)
            
            let alertPresentationArguments = self.alertPresenter.presentWasCalledWithArgs
            
            XCTAssertEqual(alertPresentationArguments?.title, "Unexpected Error")
            XCTAssertEqual(alertPresentationArguments?.message, "The Json is not valid")
            XCTAssertEqual(alertPresentationArguments?.dismissButtonTitle, "OK")
            exp.fulfill()
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
}
