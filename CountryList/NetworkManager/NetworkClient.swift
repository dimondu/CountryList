//
//  NetworkManager.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 31.10.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkManagerProtocol {
    func getRequest( completion: @escaping(Result<CountryList, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    func getRequest(completion: @escaping (Result<CountryList, NetworkError>) -> Void) {
        let urlString = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let countryList = try decoder.decode(CountryList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(countryList))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

}
