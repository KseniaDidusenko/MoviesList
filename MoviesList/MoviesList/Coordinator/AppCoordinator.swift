//
//  AppCoordinator.swift
//  MoviesList
//
//  Created by Ksenia on 04.12.2023.
//

import UIKit

class AppCoordinator: Coordinator {
  
  let window: UIWindow
  let rootViewController: UINavigationController
  let moviesListCoordinator: MoviesListCoordinator
  
  init(window: UIWindow) {
    self.window = window
    rootViewController = UINavigationController()
    moviesListCoordinator = MoviesListCoordinator(navigationController: rootViewController)
  }
  
  func start() {
    window.rootViewController = rootViewController
    moviesListCoordinator.start()
    window.makeKeyAndVisible()
  }
}
