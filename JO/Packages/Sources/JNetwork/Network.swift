//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/19.
//

import ComposableArchitecture
import Foundation

public enum JResult<T: Sendable, E: Sendable>: Sendable {
    case success(T)
    case failure(E)
}

public enum JNetworkError: Error & Sendable {
    case badUrl
    case respError
    case unowned
}

public struct JNetwork: Sendable {
    var request: @Sendable (_ target: JTarget) async throws -> Data

    public func request<T: Decodable & Sendable>(_ target: JTarget, as type: T.Type) async
        -> JResult<T, JNetworkError>
    {
        do {
            let data = try await request(target)
            let decoder = JSONDecoder()
            let result = try decoder.decode(type, from: data)
            return .success(result)
        } catch {
            return .failure(.respError)
        }
    }
}

extension DependencyValues {
    public var network: JNetwork {
        get { self[JNetwork.self] }
        set { self[JNetwork.self] = newValue }
    }
}
