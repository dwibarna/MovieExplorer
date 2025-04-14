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
        TabView {
            MovieHomeView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            FavoriteMoviesView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Favorites")
                }
                
        }
        .onAppear {
            viewModel.loadBookmarks()
        }
    }
}

#Preview {
    ContentView()
}
