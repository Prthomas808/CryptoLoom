//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import UIKit

class HomeVC: UIViewController {

  // MARK: Properties
  private var collectionView: UICollectionView!
  private let coins: [CoinModel] = CoinModel.getMockArray()
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureCollectionView()
    fetchData()
  }
  
  // MARK: Objc Functions
  
  // MARK: Helping Functions
  private func configureNavBar() {
    title = "Crypto Loom"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: nil)
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .done, target: self, action: nil)
    navigationController?.navigationBar.tintColor = UIColor(named: "AccentColor")
  }
  
  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 20
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(CoinCell.self, forCellWithReuseIdentifier: CoinCell.ReusableID)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func fetchData() {
    CryptoManager.shared.fetchCrypto { result in
      switch result {
      case .success(let coin): print("Coins have been fetched")
      case .failure(let error): print(error.rawValue)
      }
    }
  }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    coins.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCell.ReusableID, for: indexPath) as? CoinCell else {
      return UICollectionViewCell()
    }
    let coin = self.coins[indexPath.row]
    cell.configure(with: coin)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.collectionView.deselectItem(at: indexPath, animated: true)
    let coin = self.coins[indexPath.row]
    let vc = CoinDetailVC(coin: coin)
    vc.title = coin.name
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 100)
  }
}
