//
//  MoviesListPresenter.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

public protocol MoviesListViewProtocol: AnyObject {
    func updateMovies()
    func showEmptyView(isHidden: Bool)
    func showAlert(title: String, message: String)
}

protocol MoviesListPresenterProtocol: AnyObject {
    var view: MoviesListViewProtocol? { get set }
    func didSelectRow(at indexPath: IndexPath)
    func getMovie(at indexPath: IndexPath) -> Movie
    func numberOfRows() -> Int
    
    func getMovies()
    func searchMovies(with query: String)
    
    func handleRefreshControl()
}

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var coordinator: MoviesListCoordinatorProtocol?
    weak var view: MoviesListViewProtocol?
    
    private var moviesService: MoviesServiceProtocol
    
    private var currentPage: Int = 1
    
    var dataSource: [Movie] = []
    var moviesList: [Movie] = []
    var searchMoviesList: [Movie] = []
    
    // MARK: - Initialization
    
    init(
        moviesService: MoviesServiceProtocol
    ) {
        self.moviesService = moviesService
    }
    
    // MARK: - Public methods
    
    func didSelectRow(at indexPath: IndexPath) {
        let movie = getMovie(at: indexPath)
        coordinator?.goToDetails(with: movie)
    }
    
    func getMovie(at indexPath: IndexPath) -> Movie {
        return dataSource[indexPath.row]
    }
    
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func handleRefreshControl() {
        getMovies()
    }
    
    func getMovies() {
        moviesService.getMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                guard let self = self else { return }
                self.view?.showEmptyView(isHidden: true)
                self.moviesList.append(contentsOf: movies.results)
                self.dataSource = self.moviesList
                self.view?.updateMovies()
            case .failure(let error):
                self?.view?.showEmptyView(isHidden: false)
                self?.view?.updateMovies()
                self?.view?.showAlert(title: "Error", message: error.textMessage)
            }
        }
    }

    func searchMovies(with query: String) {
        
        let characterCount = query.count
        
        switch characterCount {
        case 0:
            self.dataSource = moviesList
            if self.dataSource.isEmpty {
                self.view?.showEmptyView(isHidden: false)
            } else {
                self.view?.showEmptyView(isHidden: true)}
            self.view?.updateMovies()
        default:
            moviesService.searchMovie(query: query) { [weak self] result in
                switch result {
                case .success(let movies):
                    guard let self = self else { return }
                    self.searchMoviesList = movies.results
                    let noResults = movies.results.isEmpty
                    if noResults {
                        self.view?.showEmptyView(isHidden: false)
                        self.dataSource = []
                        self.view?.updateMovies()
                    } else {
                        self.view?.showEmptyView(isHidden: true)
                        self.dataSource = self.searchMoviesList
                        self.view?.updateMovies()
                    }
                case .failure(_):
                    self?.view?.showEmptyView(isHidden: false)
                }
            }
        }
    }
}
