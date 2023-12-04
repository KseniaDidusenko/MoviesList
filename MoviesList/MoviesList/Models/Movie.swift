//
//  Movie.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let backdropPath: String?
    let posterPath: String?

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
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return true
    }
}
