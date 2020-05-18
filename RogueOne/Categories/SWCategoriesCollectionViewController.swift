//
//  SWCategoriesCollectionViewController.swift
//  RogueOne
//
//

import UIKit

class SWAllCategoryCollectionViewController: UICollectionViewController {
  private lazy var swCategoriesCollectionDataSource = SWAllCategoryCollectionViewDataSource(delegate: self)
  private var swEntitiesCollectionViewController: SWEntitiesCollectionViewController?
  private lazy var cacheManager = CacheManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Star Wars Category"
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: nil,
                                                       action: nil)
    navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.1058823529, green: 0.1411764706, blue: 0.1960784314, alpha: 0.9)
    configureCollectionView()
  }

  private func configureCollectionView() {
    collectionView.delegate = swCategoriesCollectionDataSource
    collectionView.dataSource = swCategoriesCollectionDataSource
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    collectionView.backgroundColor = .lightGray

    let cellNib = UINib(nibName: SWCategoryCollectionViewCell.reuseIdentifier, bundle: nil)
    collectionView.register(cellNib, forCellWithReuseIdentifier: SWCategoryCollectionViewCell.reuseIdentifier)
  }
}

extension SWAllCategoryCollectionViewController: SWAllCategoryCollectionViewDataSourceDelegate {

  func presentSelectedCategoryViewController(_ categoryType: SWEntityType) {
    swEntitiesCollectionViewController = SWEntitiesCollectionViewController(cacheManager: cacheManager)
    swEntitiesCollectionViewController!.categoryType = categoryType
    navigationController?.pushViewController(swEntitiesCollectionViewController!, animated: true)
  }
}
