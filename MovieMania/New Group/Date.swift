//
//  Date.swift
//  MovieMania
//
//  Created by EPIC on 03/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
struct Date : Codable {

        let maximum : String?
        let minimum : String?

        enum CodingKeys: String, CodingKey {
                case maximum = "maximum"
                case minimum = "minimum"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                maximum = try values.decodeIfPresent(String.self, forKey: .maximum)
                minimum = try values.decodeIfPresent(String.self, forKey: .minimum)
        }

}
