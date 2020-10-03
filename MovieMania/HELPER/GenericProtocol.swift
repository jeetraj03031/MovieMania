//
//  GenericProtocol.swift
//  MovieMania
//
//  Created by EPIC on 03/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
enum Favorites: String {
    case favoriteMovies = "favoriteMovies"
}


protocol Likeable {
    var favoriteType: Favorites { get }
    
    func likePressed(id: String) -> Bool
    func checkIfFavorite(id: String) -> Bool
}

