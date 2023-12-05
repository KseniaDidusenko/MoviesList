//
//  MovieEndpoints.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

enum MoviesEndpoints {
    case getMovies(page: Int)
    case searchMovie(query: String)
}

extension MoviesEndpoints: Endpoint {
    var path: String {
        switch self {
        case .getMovies:
            return "/movie/top_rated"
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        case .searchMovie:
            return .get
        }
    }
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .getMovies(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "api_key", value: "590c043ab0a50842b779c46b45574309")
            ]
        case .searchMovie(let query):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "api_key", value: "590c043ab0a50842b779c46b45574309")
            ]
            
        }
    }
}
