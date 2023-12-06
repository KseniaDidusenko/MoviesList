//
//  MovieDetailsPresenter.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import Foundation

public protocol MovieDetailsViewProtocol: AnyObject {
    func updateDetails(_ movie: Movie)
}

protocol MovieDetailsPresenterProtocol: AnyObject {
    var view: MovieDetailsViewProtocol? { get set }
    func didCloseButtonTapped()
    func getMovieDetails()
}

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    // MARK: - Properties
    
    weak var coordinator: MovieDetailsCoordinatorProtocol?
    weak var view: MovieDetailsViewProtocol?
    
    private var movie: Movie
    
    // MARK: - Initialization
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Public methods
    
    func getMovieDetails() {
        view?.updateDetails(movie)
    }
    
    func didCloseButtonTapped() {
        coordinator?.dismissMovieDetailsViewController()
    }
}
