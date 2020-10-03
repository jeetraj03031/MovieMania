//
//  NetworkManager.swift
//  MovieMania
//
//  Created by EPIC on 02/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: NSObject{
    
    static let shared : NetworkManager = NetworkManager()
        
    private override init() {
    }
    
    //MARK:- GET REQUEST WITH URL
    func getRequest(_ apiEndPoint: String,completion: @escaping(Result<Data,Error>)->Void){
        
        guard let url = URL(string: apiEndPoint) else {

            return
        }

        AF.request(url).responseData { (response) in
            switch response.result{
            case .success(let data):
                print("😊😊😊😊Data received Successfully of GET Request😊😊😊😊")
                print("==============\(url.absoluteString)=================")
                print(data)
                completion(.success(data))
                break
            case .failure(let error):
                print("😭😭😭😭Error Occurred😭😭😭😭")
                print("==============\(url.absoluteString)=================")
                completion(.failure(error))
                break
            }
        }
    }
}
enum APIEndPoint: String {
    case nowPlaying = "movie/now_playing?"
    case search = "search/movie?"
}
