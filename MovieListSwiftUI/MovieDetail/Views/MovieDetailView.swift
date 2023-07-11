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
                Spacer(minLength: UIScreen.main.bounds.height * 0.3)
                showBackgroundView
                Spacer()
            }
            
            VStack {
                showImage
                showData
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
    
    private var gradientBackground: some View {
        LinearGradient(colors: [.purple.opacity(0.5), .indigo],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var showBackgroundView: some View {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(60)
                .shadow(radius: 20)
                .overlay (
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(.indigo.opacity(0.6), lineWidth: 0.5)
                )
                .frame(height: UIScreen.main.bounds.height * 0.7)
    }
    
    private var showImage: some View {
        VStack {
            if let url = URL(string: vm.movie?.posterPath?.imageURL ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .imageScale(.small)
                .scaledToFill()
                .cornerRadius(16)
                .shadow(radius: 10)
                .frame(width: 130, height: 180)
            }
        }
        .padding(.vertical, 16)
    }
    
    private var showData: some View {
        
            VStack(alignment: .leading) {
                Text(vm.movie?.title ?? "Title")
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                
                if let genres = vm.movie?.genres {
                    let genresString = genres.compactMap { $0.name }
                    let gens = genresString.joined(separator: ", ")
                    Text(gens)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                }
                HStack {
                    Text(vm.movie?.releaseDate.stringToDate.dateToString(with: "dd MMMM YYYY") ?? "date")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(vm.movie?.voteAverage.formatDecimal ?? "")
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .lineLimit(3)
                            .foregroundColor(.brown)
                    }
                    .padding(.horizontal, 8)
                }
                .padding(.bottom, 24)
                
                Text(vm.movie?.overview ?? "Overview text")
                    .fontWeight(.regular)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black.opacity(0.9))
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 28)
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailView(id: 0)
        }
    }
}
