//
//  EmployeeTableViewCell.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/9/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    //MARK: properties
    @IBOutlet var biographyLabel: UILabel!
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var employeePhoto: UIImageView!
    
    //MARK: Methods
    func setupCell(employee: Employee?) {
        if let employee = employee {
            setupUI()
            
            teamLabel.text = employee.team
            employeePhoto.loadImageUsingCacheWithURLString(employee.photoURLSmall , placeHolder:  UIImage(named: "profilePic"))
            biographyLabel.text = employee.biography
            fullNameLabel.text = employee.fullName
        }
    }
    
    func setupUI(){
        teamLabel.textColor = UIColor.squareGray()
        employeePhoto.layer.borderWidth = 1
        employeePhoto.layer.masksToBounds = false
        employeePhoto.layer.borderColor = UIColor.clear.cgColor
        employeePhoto.layer.cornerRadius = employeePhoto.frame.height/2
        employeePhoto.clipsToBounds = true
    }
}
