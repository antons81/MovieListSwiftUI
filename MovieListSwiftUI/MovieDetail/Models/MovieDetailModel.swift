//
//  MovieDetailModel.swift
//  MovieListSwiftUI
//
//  Created by Anton Stremovskiy on 28.06.23.
//

import Foundation

// MARK: - MovieDetailsModel
struct MovieDetailsModel: Codable, Identifiable {
    let id: Int
    let title: String
    let budget: Int
    let overview: String?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let voteAverage: Double
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_title"
        case budget = "budget"
        case overview = "overview"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genres = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.budget = try container.decode(Int.self, forKey: .budget)
        self.overview = try? container.decode(String.self, forKey: .overview)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.productionCompanies = try container.decode([ProductionCompany].self, forKey: .productionCompanies)
        self.genres = try container.decode([Genres].self, forKey: .genres)
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.logoPath = try? container.decode(String.self, forKey: .logoPath)
    }
}

struct Genres: Codable, Identifiable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
