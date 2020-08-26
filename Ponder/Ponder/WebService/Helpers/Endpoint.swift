//
//  Endpoint.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base:  String { get }
    var path: String { get }
}
extension Endpoint {
    var urlComponents: URLComponents? {
        guard var components = URLComponents(string: base) else { return nil }
        components.path = path
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url ?? URL(string: "\(self.base)\(self.path)") else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    func postRequest<T: Encodable>(bodyData: [String: Any]? = [:], parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        guard var request = self.request else { return nil }
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyData ?? [:])
        request.httpBody = jsonData
        request.httpMethod = HTTPMethods.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }
    
    func postRequest(bodyData: [String: Any]? = [:], headers: [HTTPHeader]) -> URLRequest? {
        guard var request = self.request else { return nil }
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyData ?? [:])
        request.httpBody = jsonData
        request.httpMethod = HTTPMethods.post.rawValue
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }
}
