//
//  Coin.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//
import Foundation

struct CoinModel: Codable {
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank: Double?
    let maxSupply: Double?
}

extension CoinModel {
  public static func getMockArray() -> [CoinModel] {
    return [
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11),
      CoinModel(name: "Bitcoin", image: "", currentPrice: 5000, marketCap: 500, marketCapRank: 444, maxSupply: 11)
    ]
  }
}
