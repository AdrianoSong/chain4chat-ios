//
//  API.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import Foundation

enum Chain4ChatEndpoint {
    case getUser(cid: String)
    case createUser(user: User)
    case getPost(cid: String)
    
    func buildURLRequest() throws -> (URL, String, Data?) {
        let baseURL = "http://localhost:1337/"
        
        switch self {
        case .getUser(let cid):
            guard let url = URL(string: "\(baseURL)getUserByCID/\(cid)") else {
                throw APIError.invalidURL
            }
            return (url, "GET", nil)
        case .createUser(let user):
            guard let url = URL(string: "\(baseURL)createUser") else {
                throw APIError.invalidURL
            }
            let bodyData = try JSONEncoder().encode(user)
            return (url, "POST", bodyData)
        case .getPost(let cid):
            guard let url = URL(string: "\(baseURL)getPost/\(cid)") else {
                throw APIError.invalidURL
            }
            return (url, "GET", nil)
        }
    }
}

enum APIError: Error {
    case invalidURL
}

struct API {
    static func request<T: Codable>(endpoint: Chain4ChatEndpoint) async throws -> T {
        let (url, httpMethod, bodyData) = try endpoint.buildURLRequest()
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = bodyData
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
