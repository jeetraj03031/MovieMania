//
//  MovieRootModel.swift
//  MovieMania
//
//  Created by EPIC on 03/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
struct MovieRootModel : Codable {

        var dates : Date?
        var page : Int?
        let results : [Movie]?
        var totalPages : Int?
        var totalResults : Int?

        enum CodingKeys: String, CodingKey {
                case dates = "dates"
                case page = "page"
                case results = "results"
                case totalPages = "total_pages"
                case totalResults = "total_results"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                dates = try Date(from: decoder)
                page = try values.decodeIfPresent(Int.self, forKey: .page)
                results = try values.decodeIfPresent([Movie].self, forKey: .results)
                totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
                totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        }

}
