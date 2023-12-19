//
//  CryptoManager.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import Foundation

class CryptoManager {
  
  static let shared = CryptoManager()
  
  let apiKey = "9caf0c2d-3ffc-4eaf-8c36-9ef7a96160da"
  let baseURL = "https://pro-api.coinmarketcap.com"

  func fetchCrypto(completion: @escaping(Result<[CoinModel], CrytpoError>) -> Void) {
    let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&price_change_percentage=24g&locale=en"
    
    guard let url = URL(string: endpoint) else {
      completion(.failure(.invalidURL))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completion(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completion(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let coin = try decoder.decode([CoinModel].self, from: data)
        completion(.success(coin))
//        let result = try JSONSerialization.jsonObject(with: data)
      } catch {
        completion(.failure(.unableToComplete))
      }
    }
    
    task.resume()
  }
  
}

enum CrytpoError: String, Error {
  case invalidURL = "This URL is invalid"
  case unableToComplete = "There was an error trying to complete this task"
  case invalidResponse = "There was a response error"
  case invalidData = "There wan an error with the data"
}
