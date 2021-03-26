//
//  PhotoAPI.swift
//  almofire
//
//  Created by heawon on 2021/03/25.
//

import Foundation
struct PhotoAPI: Codable {
    let total: Int
    let totalPages: Int
    let results: [Results]
    
    enum CodingKeys: String, CodingKey{
        case total
        case totalPages="total_pages"
        case results
    }
}

struct Results: Codable {
    let urlLink: PhotoURL
    let description: String?
    enum CodingKeys: String, CodingKey {
        case urlLink="urls"
        case description
    }
}
struct PhotoURL: Codable{
    let full: String
    enum CodingKeys: String, CodingKey {
        case full
    }
}
