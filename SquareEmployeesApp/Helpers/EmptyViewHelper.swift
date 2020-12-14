//
//  EmptyViewHelper.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/10/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

import UIKit

extension EmployeesViewController {

    //MARK: methods
    func setEmptyMessage(_ message: String) {
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        messageLabel.isHidden = false
        
        employeesTableView.backgroundView = messageLabel
        employeesTableView.separatorStyle = .none
    }
    
    func restore() {
        employeesTableView.backgroundView = nil
        employeesTableView.separatorStyle = .singleLine
        employeesTableView.separatorColor = UIColor.squareBlue()
    }
}
