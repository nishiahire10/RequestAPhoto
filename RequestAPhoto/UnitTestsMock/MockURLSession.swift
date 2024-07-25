//
//  MockURLSession.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 22/07/24.
//

import Foundation
import Combine

class MockURLSession : URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: URLError?
    
    func customDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let data = data, let response = response else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        
        return Just((data: data, response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}

protocol URLSessionProtocol {
    func customDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

