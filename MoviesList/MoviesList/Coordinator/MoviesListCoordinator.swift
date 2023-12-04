//
//  MoviesListCoordinator.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

protocol MoviesListCoordinatorProtocol: AnyObject {
    func goToDetails(with movie: Movie)
}

class MoviesListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        let movieListVC = MoviesListViewController()
        let presenter = MoviesListPresenter()
        
        presenter.coordinator = self
        movieListVC.presenter = presenter
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(movieListVC, animated: true)
    }
}

//MARK: - MoviesListCoordinatorProtocol

extension MoviesListCoordinator: MoviesListCoordinatorProtocol {
    
    func goToDetails(with movie: Movie) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(
            navigationController: navigationController,
            movie: movie
        )
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.parentCoordinator = self
        movieDetailsCoordinator.start()
    }
}
