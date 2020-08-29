//
//  GenericAPI.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

protocol GenericAPIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, hasCookies: Bool, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension GenericAPIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, hasCookies: Bool, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String: String], let url = response?.url else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            if hasCookies {
                self.parseCookie(rawCookieString: fields["Set-Cookie"], url: url.absoluteString)
            }
            guard let data = data else { completion(nil, .invalidData); return }
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let err {
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest, hasCookies: Bool = false, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self, hasCookies: hasCookies) { (json , error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else { completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        task.resume()
    }
    
    func parseCookie(rawCookieString: String?, url: String) {
        guard let cookieString = rawCookieString, let userId = cookieString.slice(from: "USERID=", to: ";"), let userSession = cookieString.slice(from: "USERSESSION=", to: ";") else { return }
        storeCookie(key: "USERID", value: userId, domain: url)
        storeCookie(key: "USERSESSION", value: userSession, domain: url)
    }
    
    func storeCookie(key: String, value: String, domain: String) {
        if let cookie = HTTPCookie(properties: [
            .domain: domain,
            .path: "/",
            .name: key,
            .value: value
        ]) {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
}
