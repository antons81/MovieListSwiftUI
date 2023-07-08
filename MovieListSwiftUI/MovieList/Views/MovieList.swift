//
//  MovieList.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 08.07.23.
//

import SwiftUI


struct MovieList: View {
    
    private var movies: Movies
    
    init(movies: Movies) {
        self.movies = movies
    }
    
    var body: some View {
        List {
            ForEach(movies, id: \.id) { movie in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: MovieDetailView(id: movie.id)) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    MovieListCell(movie: movie)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listStyle(.plain)
        }
        .padding(.leading, -20)
        .padding(.trailing, -20)
        .scrollIndicators(.hidden)
        .navigationTitle(Text("Movie List"))
    }
}
