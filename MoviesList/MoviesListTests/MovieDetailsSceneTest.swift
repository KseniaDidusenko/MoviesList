//
//  MovieDetailsSceneTest.swift
//  MoviesListTests
//
//  Created by Ksenia on 06.12.2023.
//

import XCTest
@testable import MoviesList

final class MovieDetailsSceneTest: XCTestCase {

    var presenter: MovieDetailsPresenter!
    var movieDetailsViewMock: MovieDetailsViewMock!
    let movieMock = Movie(
        id: 238,
        title: "The Godfather",
        overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
        voteAverage: 8.708,
        backdropPath: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
        posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
    )
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieDetailsViewMock = MovieDetailsViewMock()
        presenter = MovieDetailsPresenter(movie: movieMock)
        presenter.view = movieDetailsViewMock
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieDetailsViewMock = nil
        presenter = nil
    }
    
    func testShouldUpdateView() {
        presenter.getMovieDetails()
    
      XCTAssertTrue(movieDetailsViewMock.updateViewCalled, "View not updated")
    }

    func testMovieDetailsTitleIsNotNil() {

        presenter.getMovieDetails()
        let titleToTest: String = "The Godfather"
        let viewTitle = movieDetailsViewMock.title
        
        XCTAssertNotNil(titleToTest)
        XCTAssertEqual(titleToTest, viewTitle)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
