//
//  APIKey.swift
//  MovieExplorer
//
//  Created by Dwi Aji Sobarna on 10/04/25.
//

import Foundation

enum APIKey {
    static var tmdb: String {
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let key = dict["TMDB_API_KEY"] as? String else {
            fatalError("API Key not found")
        }
        return key
              
    }
}
