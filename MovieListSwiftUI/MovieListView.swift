//
//  ContentView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

struct MovieListView: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle(Text("Movie List"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
