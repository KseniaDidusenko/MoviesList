//
//  MoviesListSceneTest.swift
//  MoviesListTests
//
//  Created by Ksenia on 06.12.2023.
//

import XCTest
@testable import MoviesList

final class MoviesListSceneTest: XCTestCase {

    var moviesServiceMock: MoviesServiceMock!
    var presenter: MoviesListPresenter!
    var moviesListViewMock: MoviesListViewMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesListViewMock = MoviesListViewMock()
        moviesServiceMock = MoviesServiceMock()
        presenter = MoviesListPresenter(moviesService: moviesServiceMock)
        presenter.view = moviesListViewMock
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        viewController = nil
        moviesServiceMock = nil
        moviesListViewMock = nil
        presenter = nil
    }

    func testMovieLisShouldCall() {
        presenter.getMovies()
        
        XCTAssertTrue(moviesServiceMock.moviesListCalled)
    }
    
    func testShouldUpdateView() {
      presenter.getMovies()
    
      XCTAssertTrue(moviesListViewMock.updateViewCalled, "View not updated")
    }

    func testMoviesListShouldCallServiceSearchMovies() {
        let movieName = "The Godfather"

        presenter.searchMovies(with: movieName)

        XCTAssertEqual(moviesServiceMock.searchMovieQueryPassed, "The Godfather")
        XCTAssertTrue(moviesServiceMock.searchMovieCalled)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
