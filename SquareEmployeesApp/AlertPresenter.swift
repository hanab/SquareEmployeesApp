//
//  AlertPresenter.swift
//  SquareEmployeesApp
//
//  Created by Hana Demas on 12/12/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

import UIKit

protocol AlertPresenterProtocol {
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String)
}

class AlertPresenter: AlertPresenterProtocol {
    
    //MARK: Methods
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        from.present(alertController, animated: true, completion: nil)
    }
}
