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
            LinearGradient(colors: [.purple.opacity(0.5), .indigo],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Spacer()
                ShowBackgroundView()
            }.ignoresSafeArea(edges: .bottom)
            
            
            ZStack {
                ShowData(vm: self.vm)
                .padding(.trailing, 16)
                .padding(.leading, 30)
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

struct ShowBackgroundView: View {
    var body: some View {
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
}

struct ShowData: View {
    
    private var vm: MovieDetailViewModel
    
    init(vm: MovieDetailViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            if let url = URL(string: vm.movie?.posterPath?.imageURL ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .imageScale(.small)
                        .scaledToFill()
                        .cornerRadius(16)
                        .shadow(radius: 10)
                        .frame(width: 120, height: 140,
                               alignment: .bottomLeading)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .offset(y: -UIScreen.main.bounds.height * 0.05)
            }
            
            
            Text(vm.movie?.title ?? "Title")
                .font(.system(size: 24))
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            if let genres = vm.movie?.genres {
                let genresString = genres.compactMap { $0.name }
                let gens = genresString.joined(separator: ", ")
                Text(gens)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
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
            
            Text(vm.movie?.overview ?? "Overview text")
                .fontWeight(.regular)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .foregroundColor(.black.opacity(0.9))
        }
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailView(id: 0)
        }
    }
}
