//
//  MovieDetailsCoordinator.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

protocol MovieDetailsCoordinatorProtocol: AnyObject {
    func dismissMovieDetailsViewController()
}

class MovieDetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let movie: Movie
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    // MARK: - Public methods
    
    func start() {
        let movieDetailsVC = MovieDetailsViewController()
        let presenter = MovieDetailsPresenter(movie: movie)
        
        presenter.coordinator = self
        presenter.view = movieDetailsVC
        movieDetailsVC.presenter = presenter
        
        navigationController.present(movieDetailsVC, animated: true)
    }
}

//MARK: - MovieDetailsCoordinatorProtocol

extension MovieDetailsCoordinator: MovieDetailsCoordinatorProtocol {
    func dismissMovieDetailsViewController() {
        navigationController.dismiss(animated: true)
        finish()
    }
}
