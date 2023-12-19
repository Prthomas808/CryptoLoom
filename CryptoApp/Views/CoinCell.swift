//
//  CoinCell.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
  // MARK: Properties
  static let ReusableID = "CoinCell"
  
  private(set) var coin: CoinModel!
  private var coinImageView = UIImageView()
  private var coinLabel = ReusableLabel(text: "Bitcoin", fontSize: 18, weight: .semibold, color: .label, numberOfLines: 1)
  
  private var bgColors: [UIColor] = [.systemRed, .systemOrange.withAlphaComponent(0.3), .systemYellow, .systemGreen, .systemBlue, .systemIndigo, .systemPurple ]
  
  // MARK: Lifecyle
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.backgroundColor = bgColors.randomElement()
    self.layer.cornerRadius = 20
    configureCoinCellProperties()
    configureCoinCellConstraitns()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Objc Functions
  
  
  // MARK: Helping Functions
  private func configureCoinCellProperties() {
    contentView.addSubview(coinImageView)
    coinImageView.contentMode = .scaleAspectFit
    coinImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
    coinImageView.tintColor = UIColor(named: "AccentColor")
    coinImageView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(coinLabel)
  }
  
  private func configureCoinCellConstraitns() {
    // coinImageView Constraints
    NSLayoutConstraint.activate([
      coinImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      coinImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      coinImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
      coinImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55)
    ])
    
    // coinImageView
    NSLayoutConstraint.activate([
      coinLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
      coinLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10)
    ])
  }
  
  public func configure(with coin: CoinModel) {
    self.coin = coin
    
    self.coinLabel.text = coin.name
  }
}
