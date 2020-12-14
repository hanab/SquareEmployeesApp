//
//  UIViewController+AlertView.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/10/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: Viewcontroller extension for displaying alert
    func displayAlertWith(title: String, message: String, style: UIAlertController.Style = .alert, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
