//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 11/04/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let path = movie.posterPath,
                   let url = URL(string: "\(APIConfig.imageBaseURL)\(path)") {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                        case .failure(let error):
                            Image(systemName: "film")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .foregroundColor(.gray)
                        @unknown default: EmptyView()
                        }
                    }
                }
                
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Movie Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
