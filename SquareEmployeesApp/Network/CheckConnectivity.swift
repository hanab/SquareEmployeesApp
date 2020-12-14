//
//  CheckConnectivity.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/10/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

import Network

class CheckConectivity {
    
    //MARK: Properies
    static let shared = CheckConectivity()
    
    //MARK: Methods
    func online(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            var err = true
            defer {
                completion(err)
                monitor.cancel()
            }
            if path.status == .satisfied {
                err = false
            } else {
                err = true
            }
        }
    }
}
