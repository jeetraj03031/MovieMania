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
    
    //Searched Movies
    var searchedMovies: [Movie] = []
    //Store Movies 
    var tempMovies: [Movie] = []
    
    //MARK:- MOVIE API
    func fetchMovies(_ page: Int,completion: @escaping()->Void){
        let endPoint = baseURL + APIEndPoint.nowPlaying.rawValue + "api_key=\(apiKey)&language=en-US&page=\(String(page))"
        
        //
        NetworkManager.shared.getRequest(endPoint) { (result) in
            switch result{
            case .success(let responseData):
                do{
                    let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as Any
                    print(">>>>>>\(jsonObj)")
                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(MovieRootModel.self, from: responseData)
                    self.Movies = []
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
    func searchMovie(_ text: String,completion: @escaping()->()){
        
        let endPoint = baseURL + APIEndPoint.search.rawValue + "api_key=\(apiKey)&query=\(text)&language=en-US&page=1"
        
        NetworkManager.shared.getRequest(endPoint) { (result) in
            switch result{
            case .success(let responseData):
                do{
                    let jsonObj = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as Any
                    print(">>>>>>\(jsonObj)")

                    let decoder = JSONDecoder()
                    let resp = try decoder.decode(MovieRootModel.self, from: responseData)
                    self.Movies = []
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
    
}
