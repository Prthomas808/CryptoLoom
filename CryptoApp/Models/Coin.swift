//
//  Coin.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//
import Foundation

struct Coin {
  let id: Int
  let name: String
  let maxSupply: Int?
  let cmcRank: Int
  let quote: Quote
  
  struct Quote {
    let USD: USD
    
    struct USD {
      let price: Double
      let marketCap: Double
    }
  }
}

extension Coin {
  public static func getMockArray() -> [Coin] {
    return [
      Coin(id: 1, name: "Bitcoin", maxSupply: 200, cmcRank: 1, quote: Quote(USD: Quote.USD(price: 50000, marketCap: 1_000_000))),
      Coin(id: 2, name: "Tether", maxSupply: nil, cmcRank: 2, quote: Quote(USD: Quote.USD(price: 2000, marketCap: 500_000))),
      Coin(id: 3, name: "Solana", maxSupply: nil, cmcRank: 3, quote: Quote(USD: Quote.USD(price: 200, marketCap: 250_000))),
      Coin(id: 4, name: "Cardano", maxSupply: 43, cmcRank: 3, quote: Quote(USD: Quote.USD(price: 200, marketCap: 250_000))),
    ]
  }
}
