//
//  Employee.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/9/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

// MARK: - Employees
struct Employees: Codable {
    
    //MARK: properties
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    
    //MARK: properties
    let uuid, fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoURLSmall, photoURLLarge: String
    let team: String
    let employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}
