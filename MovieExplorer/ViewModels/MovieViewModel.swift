//
//  MovieViewModel.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 11/04/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var bookmarkedMovieIDs: Set<Int> = []
    
    let apiKey: String = APIKey.tmdb
    
    func toogleBookmark(for movie: Movie) {
        if bookmarkedMovieIDs.contains(movie.id) {
            bookmarkedMovieIDs.remove(movie.id)
        } else {
            bookmarkedMovieIDs.insert(movie.id)
        }
        
        saveBookmarks()
    }
    
    private func saveBookmarks() {
        let array = Array(bookmarkedMovieIDs)
        UserDefaults.standard.set(array, forKey: "bookmarks")
    }
    
    func loadBookmarks() {
        let array = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] ?? []
        bookmarkedMovieIDs = Set(array)
    }
    
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
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            fetchMovies()
            return
        }
        
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "\(APIConfig.baseURL)/search/movie?api_key=\(APIKey.tmdb)&language=en-US&query=\(queryEncoded)") else {
                print("❌ URL search tidak valid")
                return
            }
        print("\(APIConfig.baseURL)/search/movie?api_key=\(APIKey.tmdb)&language=en-US&query=\(queryEncoded)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Status code: \(httpResponse.statusCode)")
            }

            
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self.movies = result.results
                }
            } catch {
                print("❌ Gagal decode search: \(error)")
            }
        }.resume()
    }
}
