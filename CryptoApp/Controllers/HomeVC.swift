//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Pedro Thomas on 12/18/23.
//

import UIKit

class HomeVC: UIViewController {

  // MARK: Properties
  private var searchBar = UISearchController(searchResultsController: nil)
  private var collectionView: UICollectionView!
  private var coins: [CoinModel] = []
  private var filteredCoin: [CoinModel] = []
//  private var isSearched: Bool = false

  
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
    configureSearchBar()
  }
  
  private func configureSearchBar() {
    searchBar.searchResultsUpdater = self
    searchBar.obscuresBackgroundDuringPresentation = false
    searchBar.hidesNavigationBarDuringPresentation = false
    searchBar.searchBar.placeholder = "Search Coin"
    navigationItem.searchController = searchBar
    navigationItem.hidesSearchBarWhenScrolling = false
    self.definesPresentationContext = false
  }
  
  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
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
    CryptoManager.shared.fetchCrypto { [weak self] result in
      switch result {
      case .success(let coin):
        DispatchQueue.main.async {
          self?.coins = coin
          self?.collectionView.reloadData()
        }
      case .failure(let error): print(error.rawValue)
      }
    }
  }
}

extension HomeVC: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    filterForSearch(searchText: searchText)
    print(searchText)
  }
  
  func filterForSearch(searchText: String) {
    filteredCoin = coins.filter{ coin in
      let searchTextMatch = coin.name.lowercased().contains(searchText.lowercased())
      return searchTextMatch
    }
    collectionView.reloadData()
    
  }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchBar.isActive {
      return filteredCoin.count
    }
    
    return coins.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCell.ReusableID, for: indexPath) as? CoinCell else {
      return UICollectionViewCell()
    }
    if searchBar.isActive {
      let coin = self.filteredCoin[indexPath.row]
      cell.configure(with: coin)
    } else {
      let coin = self.coins[indexPath.row]
      cell.configure(with: coin)
    }
 
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.collectionView.deselectItem(at: indexPath, animated: true)
    
    if searchBar.isActive {
      let coin = self.filteredCoin[indexPath.row]
      let vc = CoinDetailVC(coin: coin)
      vc.title = coin.name
      navigationController?.pushViewController(vc, animated: true)
    } else {
      let coin = self.coins[indexPath.row]
      let vc = CoinDetailVC(coin: coin)
      vc.title = coin.name
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 100)
  }
}
