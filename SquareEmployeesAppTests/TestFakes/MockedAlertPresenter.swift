//
//  MockedAlertPresenter.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/12/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit
@testable import SquareEmployeesApp


class MockedAlertPresenter: AlertPresenterProtocol {
    
    //MARK: Properites
    var presentWasCalled = false
    var presentWasCalledWithArgs: (from: UIViewController, title: String, message: String, dismissButtonTitle: String)? = nil

    //MARK: Methods
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        presentWasCalled  = true
        presentWasCalledWithArgs = (from: from, title: title, message: message, dismissButtonTitle: dismissButtonTitle)
    }
}
