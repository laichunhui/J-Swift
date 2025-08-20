//
//  File.swift
//  JO
//
//  Created by jee on 2025/8/20.
//

import Foundation
import JNetwork

struct TabDatas: Codable, Equatable {
    var title: String?
}

enum HomeApi {
    case tab(type: String)
    case header
}

extension HomeApi: JTarget {
    var method: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .tab(let type):
            return ["type": type]
        case .header:
            return nil
        }
    }
    
    var url: String {
        let baseUrl = ""
        switch self {
        case .tab:
           return baseUrl + "/tab"
        case .header:
            return baseUrl + "/header"
        }
    }
}
