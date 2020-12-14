//
//  MockUrlSession.swift
//  SquareEmployeesAppTests
//
//  Created by Hana Demas on 12/11/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SquareEmployeesApp

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    //MARK: Properties
    private (set) var resumeWasCalled = false
    
    //MARK: Functions
    func resume() {
        resumeWasCalled = true
    }
}

class MockURLSession: NetworkSessionProtocol {
    
    //MARK: Properties
    var mockData: Data?
    var mockError: Error?
    var mockDataTask = MockURLSessionDataTask()
    private (set) var mockURL: URL?
    
    //MARK: Functions
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func sessionDataTask(with request: URLRequest, completionHandler: @escaping NetworkSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        mockURL = request.url
        
        completionHandler(mockData, successHttpURLResponse(request: request), mockError)
        return  mockDataTask as URLSessionDataTaskProtocol
    }
}
