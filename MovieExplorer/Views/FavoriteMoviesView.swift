//
//  FavoriteMoviesView.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 14/04/25.
//

import SwiftUI

struct FavoriteMoviesView: View {
    
    @EnvironmentObject var viewModel: MovieViewModel
    
    private var filteredFavorites: [Movie] {
        viewModel.movies.filter {
            viewModel.bookmarkedMovieIDs.contains($0.id)
        }
    }
    
    var body: some View {
        VStack {
            if filteredFavorites.isEmpty {
                Text("Tidak ada film favorit ⭐️")
                    .foregroundColor(.gray)
                    .italic()
                    .padding()
            } else {
                List(filteredFavorites) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRowView(movie: movie, viewModel: viewModel)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favorit Saya")
    }

}
