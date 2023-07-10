//
//  ContentView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var vm = MovieListViewModel()
    @State private var searchStr = ""
    
    var filteredMovies: Movies {
        guard !searchStr.isEmpty else { return vm.movies }
        return vm.movies.filter { $0.title.localizedCaseInsensitiveContains(searchStr) }
    }
    
    var body: some View {
        NavigationStack {
            MovieList
        }
        .searchable(text: $searchStr,
                    placement: .automatic,
                    prompt: "Movie name...")
        .autocorrectionDisabled()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
