//
//  Endpoint.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var body: [String: Any]? { get }
    var header: [String: String] { get }
    var method: HTTPMethod { get }
    var queryParams: [URLQueryItem] { get }
    var timeout: TimeInterval { get }
    var completeURL: URL? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension Endpoint {
    var body: [String: Any]? {
        return nil
    }
    
    var header: [String: String] {
        return [:]
    }
    
    var queryParams: [URLQueryItem] {
        return []
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var completeURL: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3" + path
        urlComponents.queryItems = queryParams
        
        return urlComponents.url
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
}
