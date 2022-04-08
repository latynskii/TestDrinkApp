//
//  NetworkManager.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 30.03.2022.
//

import Foundation
import Alamofire


final class NetworkManager {
    static let shared = NetworkManager()
    private let link = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    
    private init() {}
    
    func fetchData(_ completion: @escaping(Result<[Cocktail], AFError>) -> ()) {
        AF.request(link)
            .validate()
            .responseDecodable(of: Drinks.self) { response in
                if let error = response.error {
                    completion(.failure(error))
                }
                guard let cocktails = response.value?.drinks else { return }
                completion(.success(cocktails))
            }
    }
}

