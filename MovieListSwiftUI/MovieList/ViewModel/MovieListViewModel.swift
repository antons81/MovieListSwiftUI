//
//  MovieListViewModel.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var movies: Movies?
    @Published var currentMovieId = 0
    
    // MARK: - Private variables
    private var tempMovies = Movies()
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
            self.tempMovies = self.movies ?? Movies()
        } catch {
            self.movies = nil
        }
    }
}
