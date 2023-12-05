//
//  MoviesResponse.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
