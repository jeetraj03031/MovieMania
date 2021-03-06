//
//  MovieListingViewModel.swift
//  MovieMania
//
//  Created by EPIC on 02/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation



class MovieListingViewModel: NSObject {
    
    //
    private let jsonD = JSONDecoder()
    
    //MOVIE ARRAY
    var Movies: [Movie] = []
   // ERROR STRING
    var error: String?
    //
    fileprivate let defaultsManager: UserDefaultsManager = UserDefaultsManager()
    //Searched Movies
    var searchedMovies: [Movie] = []
    //Store Movies 
    var tempMovies: [Movie] = []
    //
    var totalPages: Int = 0
    var totalResult: Int = 0
    
    //MARK:- MOVIE API
    func fetchMovies(_ page: Int,completion: @escaping()->Void){
        let endPoint = baseURL + APIEndPoint.nowPlaying.rawValue + "api_key=\(apiKey)&language=en-US&page=\(String(page))"
        
        //
        NetworkManager.shared.getRequest(endPoint) { (result) in
            switch result{
            case .success(let responseData):
                do{
                   // let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as Any
                   // print(">>>>>>\(jsonObj)")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(MovieRootModel.self, from: responseData)
                    self.Movies = []
                    self.totalPages = resp.totalPages ?? 0
                    self.totalResult = resp.totalResults ?? 0
                    self.Movies = resp.results ?? []
                    completion()
                }catch{
                    self.error = "Unable to parse the response"
                    completion()
                }
                break
            case .failure(let error):
                self.error = error.localizedDescription
                completion()
                break
            }
        }
    }
    
    //API FOR MOVIE SEARCH
    func searchMovie(_ text: String,page: Int,completion: @escaping()->()){
        
        let endPoint = baseURL + APIEndPoint.search.rawValue + "api_key=\(apiKey)&query=\(text)&language=en-US&page=\(String(page))"
        
        NetworkManager.shared.getRequest(endPoint) { (result) in
            switch result{
            case .success(let responseData):
                do{
                    //let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as Any
                    //print(">>>>>>\(jsonObj)")

                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(MovieRootModel.self, from: responseData)
                    self.Movies = []
                    self.Movies = resp.results ?? []
                    self.totalPages = resp.totalPages ?? 0
                    self.totalResult = resp.totalResults ?? 0
                    completion()
                }catch{
                    self.error = "Unable to parse the response"
                    completion()
                }
                break
            case .failure(let error):
                self.error = error.localizedDescription
                completion()
                break
            }
        }

        
    }
    
}
extension MovieListingViewModel: Likeable{
    func likePressed(id: String) -> Bool {
        let buttonStatus = defaultsManager.toggleFavorites(id: id, type: .favoriteMovies)
         if (buttonStatus) {
             return true
         } else {
             return false
         }
    }
    
    func checkIfFavorite(id: String) -> Bool {
        if (defaultsManager.checkIfFavorite(id: id, type: .favoriteMovies)) {
            return true
        } else  {
            return false
        }
    }
    
    
    var favoriteType: Favorites{
        .favoriteMovies
    }
}
