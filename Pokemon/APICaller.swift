//
//  APICaller.swift
//  Pokemon
//
//  Created by Begüm Tüzüner on 31.07.2023.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    private init(){
        
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    func fetchPosts(completion: @escaping (Result<[Card], Error>) -> Void) {
        let apiURLString = "https://api.pokemontcg.io/v1/cards?hp=gte99"

        guard let url = URL(string: apiURLString) else {
//            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do{
                let result = try JSONDecoder().decode(SearchResponse.self, from: data)
//                print(result)
                completion(.success(result.cards))
            }
            catch{
//                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    
//    func fetchPosts(completion: @escaping ([SearchResponse]?, Error?) -> Void) {
//        let apiURLString = "https://api.pokemontcg.io/v1/cards?hp=gte99"
//
//        guard let url = URL(string: apiURLString) else {
//            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//
//            guard let data = data else {
//                completion(nil, NSError(domain: "No data received", code: -2, userInfo: nil))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let posts = try decoder.decode([SearchResponse].self, from: data)
//                completion(posts, nil)
//            } catch {
//                completion(nil, error)
//            }
//        }
//
//        task.resume()
//    }
}



