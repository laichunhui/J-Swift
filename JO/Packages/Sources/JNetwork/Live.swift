//
//  File 2.swift
//  Packages
//
//  Created by jee on 2025/8/19.
//

import Alamofire
import ComposableArchitecture
import Foundation
import JKit

extension JNetwork: DependencyKey {
    public static var liveValue: JNetwork {
        let network = Network()
        return JNetwork(
            request: { target in
                try await network.request(target)
            }
        )
    }

    public static var testValue: JNetwork {
        JNetwork(
            request: { _ in
                throw JNetworkError.unowned
            }
        )
    }
}

private actor Network {
    func request(_ target: JTarget) async throws -> Data {
        guard let url = URL(string: target.url) else {
            throw JNetworkError.badUrl
        }

        let resp = await AF.request(
            url,
            method: target.method,
            parameters: target.parameters,
            encoding: URLEncoding.default,
            headers: target.headers
        )
        .serializingData()
        .response

        if let data = resp.value {
            return data
        } else if let error = resp.error {
            Logger.error("\(error)")
            throw JNetworkError.respError
        }
        throw JNetworkError.unowned
    }
}
