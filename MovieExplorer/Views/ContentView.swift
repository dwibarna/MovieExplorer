//
//  ContentView.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 10/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRowView(movie: movie)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Film Populer")
        }
        .onAppear {
            print("📡 Fetching movie...")
            viewModel.fetchMovies()
        }
    }
}

#Preview {
    ContentView()
}
