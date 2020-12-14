//
//  EmployeesViewModel.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/10/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

protocol EmployeesViewModelProtocol {
    func fetchData(completion: (() -> ())?)
}

class EmployeesViewModel: EmployeesViewModelProtocol {
    
 //MARK: Properties
    private var employees = [Employee]()
    private var apiGateway:GateWayProtocol?
    private var networkError: NetworkError?
   
   //MARK: init
    init(gateWay: GateWayProtocol = EmployeesAPIGateway(session: URLSession.shared)) {
        self.apiGateway = gateWay
        networkError = nil
    }
   
     //MARK: Methods
   func fetchData(completion: (() -> ())?) {
        if let apiGateway = apiGateway {
            apiGateway.fetchAllEmployees { [weak self] response in
                guard let strongSelf = self else {
                    return
                }
                switch(response) {
                case let .Success(employees):
                    strongSelf.employees  = employees.employees
                    completion?()
                case let .Failure(error) :
                    strongSelf.networkError = error
                    completion?()
                }
            }
        }
    }
    
    //MARK: functions to prepare data for UITablview
    func getNumberOfEmployees() -> Int {
        return employees.count
    }
    
    func getEmployeeAtIndex(index:Int) -> Employee? {
        guard index < employees.count else {
            return nil
        }
        
        return employees[index]
    }
    
    func getNetworkError() -> NetworkError? {
        return networkError
    }
}
