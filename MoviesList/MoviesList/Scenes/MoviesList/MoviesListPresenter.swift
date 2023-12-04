//
//  MoviesListPresenter.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

protocol MoviesListViewProtocol: AnyObject {
}

protocol MoviesListPresenterProtocol: AnyObject {
    var view: MoviesListViewProtocol? { get set }
    var moviesList: [Movie] { get set }
    func didSelectRow(at indexPath: IndexPath)
    func getMovie(at indexPath: IndexPath) -> Movie
    func numberOfRows() -> Int
    
}

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var coordinator: MoviesListCoordinatorProtocol?
    weak var view: MoviesListViewProtocol?
    
    var moviesList: [Movie] = [Movie(id: 1, title: "first", overview: "sdddddd", voteAverage: 9, backdropPath: "", posterPath: "")]
    
    // MARK: - Initialization
    
    // MARK: - Public methods
    
    func didSelectRow(at indexPath: IndexPath) {
        let movie = getMovie(at: indexPath)
        coordinator?.goToDetails(with: movie)
    }
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return moviesList[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return moviesList.count
    }
}
