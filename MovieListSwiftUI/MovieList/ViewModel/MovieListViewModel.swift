//
//  MovieListViewModel.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    
    @Published var movies: Movies = Movies()
    
    // MARK: - Private variables
    private let networkManager = NetworkManager()
    
    init() {
        Task {
            await self.composeMovies()
        }
    }
    
    @MainActor func composeMovies() async {
        do {
            let movies = try await networkManager.fetchTrendingMovies(model: Movies.self)
            self.movies = movies
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
