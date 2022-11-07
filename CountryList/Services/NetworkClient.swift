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

enum Api: String {
    case api = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, for url: String?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping((Data) -> Void)) {
        guard let urlString = url, let url = URL(string: urlString) else { return }
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: url) else { return }
                    DispatchQueue.main.async {
                        completion(imageData)
                    }
                            
                }
        
    }
}
