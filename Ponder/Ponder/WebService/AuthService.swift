//
//  AuthService.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

class AuthService: GenericAPIClient {
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func signUp(signInData: [String: Any], completion: @escaping (Result<SignInId, APIError>) -> ()) {
        guard let request = AuthType.signup.postRequest(bodyData: signInData, headers: [HTTPHeader.contentType("application/json")]) else { return }
        fetch(with: request, decode: { json -> SignInId? in
            guard let results = json as? SignInId else { return  nil }
            return results
        }, completion: completion)
    }
    
}

struct SignInId: Decodable {
    let id: String
}

enum AuthType {
    case signup
    case login
}

extension AuthType: Endpoint {
    var base: String {
        return "http://localhost:8080"
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/v1/user"
        case .login:
            return "/v1/login"
        }
    }
}
