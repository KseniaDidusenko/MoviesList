//
//  MoviesListCoordinator.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class MoviesListCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private var movieListViewController: MoviesListViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieListVC = MoviesListViewController()
        let presenter = MoviesListPresenter()
        
        movieListVC.presenter = presenter
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(movieListVC, animated: true)
        self.movieListViewController = movieListVC
    }
}
