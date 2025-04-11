//
//  MovieViewModel.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 11/04/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    let apiKey: String = APIKey.tmdb
    
    func fetchMovies() {
        guard let url = URL(string: "\(APIConfig.baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            print("❌ URL invalid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = decoded.results
                        print("✅ Dapat \(decoded.results.count) film")
                    }
                } catch {
                    print("❌ Gagal decode: \(error)")
                }
            }
        }.resume()
    }
}
