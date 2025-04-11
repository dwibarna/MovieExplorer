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
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Film Populer")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}


#Preview {
    ContentView()
}
