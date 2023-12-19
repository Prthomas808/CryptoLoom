//
//  CoinDetailVC.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import UIKit

class CoinDetailVC: UIViewController {

  // MARK: Properties
  private let coin: CoinModel
  
  private var coinImageView = UIImageView()
  private var rankLabel = ReusableLabel(text: nil, fontSize: 18, weight: .light, color: .systemGreen, numberOfLines: 1)
  private var priceLabel = ReusableLabel(text: nil, fontSize: 18, weight: .light, color: .systemPurple, numberOfLines: 1)
  private var marketCapLabel = ReusableLabel(text: nil, fontSize: 18, weight: .light, color: .systemRed, numberOfLines: 1)
  private var maxSupplyLabel = ReusableLabel(text: nil, fontSize: 18, weight: .light, color: .systemYellow, numberOfLines: 1)
  private var vStack: UIStackView!
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureCoinDetailProperties()
    configureCoinDetailConstraints()
  }
  
  init(coin: CoinModel) {
    self.coin = coin
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Helping Functions
  private func configureNavBar() {
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
  }
  
  private func configureCoinDetailProperties() {
    view.addSubview(coinImageView)
    coinImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
    coinImageView.tintColor = .systemOrange
    coinImageView.translatesAutoresizingMaskIntoConstraints = false
    
    vStack = UIStackView(arrangedSubviews: [rankLabel, marketCapLabel, priceLabel, maxSupplyLabel])
    view.addSubview(vStack)
    vStack.axis = .vertical
    vStack.spacing = 12
    vStack.distribution = .fill
    vStack.alignment = .leading
    vStack.translatesAutoresizingMaskIntoConstraints = false
    
    guard let rank = coin.marketCapRank else { return }
    guard let marketCap = coin.marketCap else { return }
    rankLabel.text = "Rank: \(rank)"
    priceLabel.text = "Price: \(coin.currentPrice)"
    marketCapLabel.text = "Market Cap: \(marketCap)"
        
  }

  private func configureCoinDetailConstraints() {
    // coinImageView Constraints
    NSLayoutConstraint.activate([
      coinImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      coinImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      coinImageView.heightAnchor.constraint(equalToConstant: 150),
      coinImageView.widthAnchor.constraint(equalToConstant: 150),
    ])
    
    NSLayoutConstraint.activate([
      vStack.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
      vStack.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
      vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
    ])
  }
  
}
