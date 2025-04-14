//
//  MovieRowVIew.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 11/04/25.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Poster
            if let path = movie.posterPath,
               let url = URL(string: "\(APIConfig.imageBaseURL)\(path)") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 80, height: 120)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(movie.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Image(systemName: viewModel.bookmarkedMovieIDs.contains(movie.id) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            viewModel.toogleBookmark(for: movie)
                        }
                }

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 6)
    }
}



