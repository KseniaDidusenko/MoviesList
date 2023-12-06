//
//  MoviesServiceMock.swift
//  MoviesListTests
//
//  Created by Ksenia on 06.12.2023.
//

import Foundation
import MoviesList

class MoviesServiceMock: MoviesServiceProtocol {

    var moviesListReturned: (Result<MoviesResponse, MovieErrors>)?
    private(set) var moviesListCalled = false
    
    func getMovies(page: Int, completion: @escaping (Result<MoviesList.MoviesResponse, MoviesList.MovieErrors>) -> Void) {
        
        moviesListCalled = true

        guard let moviesListReturned = moviesListReturned else {
            return completion(.failure(MovieErrors.noData))
        }

        return completion(moviesListReturned)
    }
    
    var searchMovieReturned: (Result<MoviesResponse, MovieErrors>)?
    private(set) var searchMovieCalled = false
    private(set) var searchMovieQueryPassed: String?
    
    func searchMovie(query: String, completion: @escaping (Result<MoviesList.MoviesResponse, MoviesList.MovieErrors>) -> Void) {
        searchMovieCalled = true
        searchMovieQueryPassed = query

        guard let searchMovieReturned = searchMovieReturned else {
            return completion(.failure(MovieErrors.noData))
        }

        return completion(searchMovieReturned)
    }
}
