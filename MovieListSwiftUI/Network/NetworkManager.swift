//
//  NetworkManager.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import Foundation

private struct BaseHost {
    
    static var url: String {
        return "https://api.themoviedb.org"
    }
    
    static var imageUrl: String {
        return "https://image.tmdb.org/t/p/w500"
    }
}

extension String {
    var imageURL: String {
        return BaseHost.imageUrl + self
    }
}

private struct ApiKey {
    static var value: String {
        return "?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
    }
}

private enum EndPoints {
    case trending
    case details(_ movieId: Int)
}

private extension EndPoints {
    var endPoint: String {
        switch self {
        case .trending: return "/3/discover/movie\(ApiKey.value)"
        case .details(let id): return "/3/movie/\(id)\(ApiKey.value)"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
}

final class NetworkManager {
    
    private let session: URLSession!
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    
    // MARK: - Task function
    private func runTask<T: Decodable>(with url: URL,
                                       model: T.Type,
                                       key: String? = nil) async throws -> T {
        
        let (data,_) = try await session.data(from: url)
        
        if key == nil {
            return try JSONDecoder().decode(model, from: data)
        }
        
        return try JSONDecoder().decode(model,
                                        from: data,
                                        keyPath: key ?? "")
    }
    
    
    // MARK: - Fetch Trending movie list
    func fetchTrendingMovies<T: Decodable>(model: T.Type) async throws -> T {
        let stringUrl = BaseHost.url + EndPoints.trending.endPoint
        
        guard let escapedUrlString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: escapedUrlString) else {
            throw NetworkError.invalidURL
        }
        
        let response = try await runTask(with: url, model: model, key: "results")
        return response
    }
    
    
    // MARK: - Fetch movie details
    func fetchMovieDetails<T: Decodable>(model: T.Type,
                                         id: Int) async throws -> T {
        let stringUrl = BaseHost.url + EndPoints.details(id).endPoint
        
        guard let escapedUrlString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: escapedUrlString) else {
            throw NetworkError.invalidURL
        }
        
        let response = try await runTask(with: url, model: model)
        return response
    }
}

