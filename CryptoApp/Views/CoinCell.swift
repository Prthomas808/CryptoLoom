//
//  CoinCell.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import UIKit
import SDWebImage

class CoinCell: UICollectionViewCell {
    
  // MARK: Properties
  static let ReusableID = "CoinCell"
  
  private(set) var coin: CoinModel!
  private var coinImageView = UIImageView()
  private var coinLabel = ReusableLabel(text: "Bitcoin", fontSize: 18, weight: .semibold, color: .label, numberOfLines: 2)
  
  private var bgColors: [UIColor] = [.systemRed, .systemOrange.withAlphaComponent(0.5), .systemYellow.withAlphaComponent(0.5), .systemGreen, .systemBlue, .systemIndigo, .systemPurple ]
  
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
    coinImageView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(coinLabel)
    coinLabel.lineBreakMode = .byWordWrapping
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
      coinLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
      coinLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
    ])
  }
  
  public func configure(with coin: CoinModel) {
    self.coin = coin
    
    self.coinLabel.text = coin.name
    
    guard let coinImage = URL(string: coin.image) else { return }
    coinImageView.sd_setImage(with: coinImage)
    
  }
}
