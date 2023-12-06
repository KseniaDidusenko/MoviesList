//
//  MoviesListViewMock.swift
//  MoviesListTests
//
//  Created by Ksenia on 06.12.2023.
//

import Foundation
import MoviesList

class MoviesListViewMock: MoviesListViewProtocol {
    var updateViewCalled = false
    
    func updateMovies() {
        updateViewCalled = true
    }
    
    func showEmptyView(isHidden: Bool) {}
    func showAlert(title: String, message: String) {}
    
    
}
