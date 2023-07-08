//
//  MovieDetailViewModel.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 28.06.23.
//

import Foundation
import SwiftUI

typealias Movie = MovieDetailsModel

final class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Observers
    @Published var movie: Movie?
    
    // MARK: - Private variables
    private let networkManager = NetworkManager()
    

    @MainActor func fetchMovieDetails(_ id: Int) async {
        do {
            self.movie = try await networkManager
                .fetchMovieDetails(model:
                                    Movie.self,
                                   id: id)
        } catch {
            self.movie = nil
        }
    }
}
