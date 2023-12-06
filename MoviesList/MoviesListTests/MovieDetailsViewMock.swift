//
//  MovieDetailsViewMock.swift
//  MoviesListTests
//
//  Created by Ksenia on 06.12.2023.
//

import Foundation
import MoviesList

class MovieDetailsViewMock: MovieDetailsViewProtocol {
    
    var updateViewCalled = false
    var title: String?
    
    func updateDetails(_ movie: Movie) {
        updateViewCalled = true
        title = movie.title
    }
}
