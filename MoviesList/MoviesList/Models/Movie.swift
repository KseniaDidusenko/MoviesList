//
//  Movie.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

public struct Movie: Decodable {
    public let id: Int
    public let title: String
    public let overview: String
    public let voteAverage: Double
    public let backdropPath: String?
    public let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return true
    }
}
