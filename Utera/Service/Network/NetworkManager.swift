//
//  NetworkManager.swift
//  Utera
//
//  Created by Bee Wijaya on 21/08/26.
//
import SwiftUI
import Alamofire

protocol INetworkManager<T, U> {
    associatedtype T: Codable & Sendable
    associatedtype U: Codable & Sendable
    func get(path: String) async throws -> T
    func post(path: String, body: U) async throws -> T
}

final class NetworkManager<T: Sendable & Codable, U: Codable & Sendable>: INetworkManager {
    var host = ""
    var username = ""
    var password = ""
    
    init(host: String) {
        self.host = host
        self.username = AppConfig.stringValue(forKey: "API_USERNAME")
        self.password = AppConfig.stringValue(forKey: "API_PASSWORD")
    }
    
    func get(path: String) async throws -> T {
        let res = try await AF.request("\(host)/\(path)")
            .cacheResponse(using: .cache)
            .validate()
            .cURLDescription { print($0) }
            .serializingDecodable(T.self)
            .value
    
        return res
    }
    
    func post(path: String, body: U) async throws -> T {
        let res = try await AF.request(
                "\(host)\(path)",
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
            .authenticate(username: username, password: password)
            .cacheResponse(using: .cache)
            .validate()
            .cURLDescription { print($0) }
            .serializingDecodable(T.self)
            .value
        
        return res
    }
}
