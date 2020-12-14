//
//  MockViewModel.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SquareEmployeesApp

class MockViewModel: EmployeesViewModelProtocol {
    
    //MARK: Properties
    var fetchCalled = false
    
    //MARK: methods
    func fetchData(completion: (() -> ())?) {
        fetchCalled = true
    }
}
