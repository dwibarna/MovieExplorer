//
//  MovieHomeView.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 14/04/25.
//

import SwiftUI

struct MovieHomeView : View {
    @EnvironmentObject var viewModel: MovieViewModel
    @State private var searchQuery = ""

    var body: some View {
        NavigationStack {
            TextField("Cari film..", text: $searchQuery)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .task(id: searchQuery) {
                    viewModel.searchMovies(query: searchQuery)
                }

            
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRowView(movie: movie, viewModel: viewModel)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Film Populer")
        }
    }
}
