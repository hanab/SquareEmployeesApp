//
//  JSonParsingHelper.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

class JSonParsingHelper {
    
    //MARK: Methods
    class func data(forJson name: String) -> Data? {
        let bundle = Bundle(for: self)
        let url = bundle.url(forResource: name, withExtension: "json")!
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}
