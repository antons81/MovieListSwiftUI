//
//  MovieDetailView.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 28.06.23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject var vm = MovieDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        ZStack {
            
            gradientBackground
            
            VStack {
                Spacer().frame(maxWidth: .infinity)
                showBackgroundView
            }
            .frame(alignment: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            showImage
                .offset(y: -(UIScreen.main.bounds.height * 0.7) / 4 - 90)
                .padding(.bottom, 16)
            
            
            ZStack {
                VStack {
                    showData.offset(y: 45)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                }
            }
        })
        .onAppear {
            Task {
                await vm.fetchMovieDetails(self.id)
            }
        }
    }
}


// MARK: - COMPONENTS

extension MovieDetailView {
    
    var radius: CGFloat {
        return 30
    }
    
    private var gradientBackground: some View {
        LinearGradient(colors: [.purple.opacity(0.5), .indigo],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var showBackgroundView: some View {
        Rectangle()
            .fill(.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .shadow(radius: 20)
            .frame(height: UIScreen.main.bounds.height * 0.7)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    private var showImage: some View {
        VStack {
            if let url = URL(string: vm.movie?.posterPath?.imageURL ?? "") {
                AsyncImage(url: url,
                           transaction: Transaction(animation: .smooth)) { phase in
                    
                    switch phase {
                    case .success(let image):
                        image.resizable()
                    case .empty:
                        Image("movie_placeholder")
                    case .failure(_):
                        Image("movie_placeholder")
                    @unknown default: EmptyView()
                    }
                }
                .imageScale(.small)
                .scaledToFill()
                .cornerRadius(16)
                .shadow(radius: 10)
                .frame(width: 130, height: 180)
            } else {
                Image("movie_placeholder")
                    .resizable()
                    .imageScale(.small)
                    .scaledToFill()
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .frame(width: 130, height: 180)
            }
        }
    }
    
    private var showData: some View {
        
        VStack(alignment: .leading) {
            Text(vm.movie?.title ?? "Movie name")
                .font(.system(size: 24))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            if let genres = vm.movie?.genres {
                let genresString = genres.compactMap { $0.name }
                let gens = genresString.joined(separator: ", ")
                Text(gens)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
            }
            
            HStack {
                Text(vm.movie?.releaseDate.stringToDate.dateToString(with: "dd MMMM YYYY") ?? Date().dateToString(with: nil))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
                
                HStack {
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(vm.movie?.voteAverage.formatDecimal ?? "5.0")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .lineLimit(3)
                        .foregroundColor(.brown)
                }
                .padding(.horizontal, 8)
            }
            .padding(.bottom, 16)
            
            Text(vm.movie?.overview ?? "Overview text sfsfsfsdf dffdsfdf dsfsfsfsdfd fdsfdfdfsdf dffsdfsdfsd dsfdsfsdfdsfds dfsdfsdfds sdffdfsdfd")
                .fontWeight(.regular)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .foregroundColor(.black.opacity(0.9))
                .padding(.bottom, 16)
        }.padding(.horizontal, 18)
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailView(id: 0)
        }
    }
}
