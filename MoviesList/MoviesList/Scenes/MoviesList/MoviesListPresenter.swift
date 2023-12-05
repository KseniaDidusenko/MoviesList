//
//  MoviesListPresenter.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

protocol MoviesListViewProtocol: AnyObject {
    func updateMovies(_ movies: [Movie])
}

protocol MoviesListPresenterProtocol: AnyObject {
    var view: MoviesListViewProtocol? { get set }
    var moviesList: [Movie] { get set }
    func didSelectRow(at indexPath: IndexPath)
    func getMovie(at indexPath: IndexPath) -> Movie
    func numberOfRows() -> Int
    func getMovies()
    func userRequestedMoreData()
}

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var coordinator: MoviesListCoordinatorProtocol?
    weak var view: MoviesListViewProtocol?
    private var moviesService: MoviesServiceProtocol
    private var currentPage: Int = 1
    
    var moviesList: [Movie] = []
    
    // MARK: - Initialization
    
    init(
        moviesService: MoviesServiceProtocol = MoviesService()
    ) {
        self.moviesService = moviesService
    }
    
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
    
    func getMovies() {
        moviesService.getMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let self = self else { return }
                self.moviesList.append(contentsOf: movies.results)
                self.currentPage = movies.page + 1
                self.view?.updateMovies(self.moviesList)
            case .failure(let error):
                break
            }
        }
    }
    
    func userRequestedMoreData() {
        getMovies()
    }
}
