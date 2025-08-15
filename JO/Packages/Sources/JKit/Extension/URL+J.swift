//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/15.
//

import Foundation

extension URL: IJExtension {}

extension JExtension where Base == URL {
    func queryToDictionary() -> [String: Any]? {
        var params = [String: Any]()
        if  let components = URLComponents(url: base, resolvingAgainstBaseURL: false) {
            components.queryItems?.forEach({ item in
                params[item.name] = item.value
            })
        }
        return params
    }
    
    func add(queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents.init(string: base.absoluteString) else {
            return base
        }
        
        if components.queryItems == nil {
            components.queryItems = queryItems
        } else {
            components.queryItems?.append(contentsOf: queryItems)
        }
        guard let url = components.url else { return base }
        return url
    }
    
    func add(queryStrig: String) -> URL? {
        guard var components = URLComponents.init(string: base.absoluteString) else {
            return base
        }
        components.query = queryStrig
        guard let url = components.url else { return base }
        return url
    }
    
    
    func del(queryKey: String) -> URL? {
        guard var components = URLComponents.init(string: base.absoluteString) else {
            return base
        }
        if var queryItems = components.queryItems {
            queryItems.removeAll(where: {$0.name == queryKey})
            components.queryItems = queryItems
        }
        guard let url = components.url else { return base }
        return url
    }
}
