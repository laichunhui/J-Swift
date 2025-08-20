//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/20.
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Parameters = Alamofire.Parameters
public typealias HTTPHeaders = Alamofire.HTTPHeaders

public protocol JTarget: Sendable {
    /// full `URL`.
    var url: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The headers to be used in the request.
    var headers: HTTPHeaders? { get }
    
    var parameters: Parameters? { get }
}
