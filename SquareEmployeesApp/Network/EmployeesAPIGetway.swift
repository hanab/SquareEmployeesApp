//
//  EmployeesAPIGetway.swift
//  SquareEmployeesApp
//
//  Created by Hana  Demas on 12/9/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

enum EmployeesResult {
    case Success(Employees)
    case Failure(NetworkError?)
}

enum NetworkError: String, Error {
    case InvalidJSONData = "The Json is not valid"
    case InvalidResponse = "Invalid Server response, Please try again"
    case TimeOut = "Request timed out, please try again"
    case MalformedURL = "Url is malformed"
    case OtherNetworkError = "A network error occured, please try again"
}


protocol GateWayProtocol {
    func fetchAllEmployees( completion: @escaping (EmployeesResult) -> Void)
    func fetchAllEmployees(url: URL, completion: @escaping (EmployeesResult) -> Void)
}

class EmployeesAPIGateway: GateWayProtocol {
    
    //MARK: Properties
    private let session: NetworkSessionProtocol
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    //MARK: Init
    init(session: NetworkSessionProtocol) {
        self.session = session
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    //MARK: Methods
    func fetchAllEmployees(url: URL, completion: @escaping (EmployeesResult) -> Void) {
        let request = URLRequest(url: url)
        let task = session.sessionDataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            
            // this could be made general and print the error.description, instead of handling individula errors
            if let error = error {
                
                if((error as NSError).code == NSURLErrorTimedOut) {
                    completion(.Failure(NetworkError.TimeOut))
                } else if((error as NSError).code == NSURLErrorBadURL) {
                    completion(.Failure(NetworkError.MalformedURL))
                } else {
                    completion(.Failure(NetworkError.OtherNetworkError))
                }
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.Failure(NetworkError.InvalidResponse))
                
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Employees.self, from: data)
                    completion(.Success(decodedResponse))
                } catch {
                    completion(.Failure(NetworkError.InvalidJSONData))
                }
            }
        })
        task.resume()
    }
    
    func fetchAllEmployees( completion: @escaping (EmployeesResult) -> Void) {
        let urlString = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
        let url = URL(string: urlString)!
        
        fetchAllEmployees(url: url, completion: completion)
    }
}

