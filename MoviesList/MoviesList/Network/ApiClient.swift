//
//  ApiClient.swift
//  MoviesList
//
//  Created by Ksenia on 05.12.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum ApiURLs {
    static let imageURL = "https://image.tmdb.org/t/p/w342"
}

class ApiClient {
    
    static let shared = ApiClient()
    
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, MovieErrors>) -> Void) {
        
        guard let url = endpoint.completeURL else {
            completion(.failure(.badUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = endpoint.header
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.timeoutInterval = endpoint.timeout
        urlRequest.cachePolicy = endpoint.cachePolicy
        
        if let body = endpoint.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.parsingError))
                }
            case 401:
                completion(.failure(.unauthorizedError))
            case 404:
                completion(.failure(.notFoundError))
            case 500:
                completion(.failure(.serverError))
            default:
                completion(.failure(.unknownError))
            }
        }
        task.resume()
    }
}
