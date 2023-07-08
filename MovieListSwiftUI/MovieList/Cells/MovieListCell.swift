//
//  MovieListCellView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 25.06.23.
//

import SwiftUI

struct MovieListCell: View {
    
    private var movie: MovieListModel
    
    init(movie: MovieListModel) {
        self.movie = movie
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.purple,
                                                .indigo],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .frame(height: 160)
                    .cornerRadius(10)
            }
            .shadow(radius: 3, y: 4)
            
            HStack(alignment: .top) {
                
                    if let fullUrl = movie.posterPath?.imageURL,
                       let url = URL(string: fullUrl) {
                        
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .imageScale(.small)
                                .frame(width: 100, height: 140, alignment: .bottomLeading)
                                .aspectRatio(contentMode: .fill)
                            
                            
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal, 8)
                    }
                
                
                VStack(alignment: .leading) {
                    
                    Text(movie.title)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .lineLimit(3)
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    
                    HStack() {
                        Text("Year:")
                            .fontWeight(.bold)
                            .font(.headline)
                            .lineLimit(1)
                            .foregroundColor(.white)
                        
                        Text(movie.releaseDate.stringToDate.dateToString(with: "YYYY"))
                            .fontWeight(.medium)
                            .font(.subheadline)
                            .lineLimit(2)
                            .foregroundColor(.white)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(movie.voteAverage.formatted())")
                                .fontWeight(.medium)
                                .font(.subheadline)
                                .lineLimit(3)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
        }
    }
}
