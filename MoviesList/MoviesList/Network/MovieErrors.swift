//
//  MovieErrors.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

enum MovieErrors: Error {
    case badRequest
    case unauthorizedError
    case notFoundError
    case serverError
    case badUrl
    case noData
    case parsingError
    case unknownError
    
    var textMessage: String {
        switch self {
        case .badRequest:
            return "Bad request!"
        case .unauthorizedError:
            return "Invalid API key: You must be granted a valid key"
        case .notFoundError:
            return "404: The URL doesn't exist"
        case .serverError:
            return "500:  Internal Server Error"
        case .badUrl:
            return "The URL doesn't exist"
        case .noData:
            return "No data"
        case .parsingError:
            return "Couldn't parse data"
        case .unknownError:
            return "Unknown error"
        }
    }
}
