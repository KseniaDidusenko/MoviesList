//
//  MovieService.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func getMovies(page: Int, completion: @escaping (Result<MoviesResponse, MovieErrors>) -> Void)
    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, MovieErrors>) -> Void)
}

class MoviesService: MoviesServiceProtocol {
    
    private let apiClient = ApiClient.shared
    
    func getMovies(page: Int, completion: @escaping (Result<MoviesResponse, MovieErrors>) -> Void) {
        apiClient.request(
            endpoint: MoviesEndpoints.getMovies(page: page),
            completion: completion
        )
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, MovieErrors>) -> Void) {
        apiClient.request(
            endpoint: MoviesEndpoints.searchMovie(query: query),
            completion: completion
        )
    }
}
