//
//  ContentView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var vm = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let movies = vm.movies {
                    ForEach(movies) { movie in
                        Text(movie.title)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle(Text("Movie List"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
