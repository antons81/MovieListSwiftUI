//
//  ContentView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject private var vm = MovieListViewModel()
    @State private var searchStr = ""
    
    var filteredMovies: Movies {
        guard let movies = vm.movies else { return Movies() }
        guard !searchStr.isEmpty else { return movies }
        return movies.filter { $0.title.localizedCaseInsensitiveContains(searchStr) }
    }
    
    var body: some View {
        NavigationStack {
            MovieList(movies: filteredMovies)
        }
        .searchable(text: $searchStr,
                    placement: .toolbar,
                    prompt: "Movie name...")
        .autocorrectionDisabled()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
