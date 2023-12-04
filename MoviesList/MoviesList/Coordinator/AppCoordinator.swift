//
//  AppCoordinator.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let moviesListCoordinator: MoviesListCoordinator
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        moviesListCoordinator = MoviesListCoordinator(navigationController: rootViewController)
    }
    
    // MARK: - Public methods
    
    func start() {
        window.rootViewController = rootViewController
        moviesListCoordinator.parentCoordinator = self
        childCoordinators.append(moviesListCoordinator)
        moviesListCoordinator.start()
        window.makeKeyAndVisible()
    }
}
