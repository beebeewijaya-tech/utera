//
//  NetworkManager.swift
//  Utera
//
//  Created by Bee Wijaya on 21/08/26.
//
import SwiftUI
import Alamofire

protocol INetworkManager<T> {
    associatedtype T
    func get<T: Sendable & Decodable>() async throws -> T
}

final class NetworkManager: Sendable {
    static let shared = NetworkManager()
    let host = "https://jsonplaceholder.typicode.com"
    
    func get<T: Sendable & Decodable>() async throws -> T {
        let res = try await AF.request("\(host)/photos")
            .cacheResponse(using: .cache)
            .validate()
            .cURLDescription { print($0) }
            .serializingDecodable(T.self)
            .value
    
        return res
    }
}
