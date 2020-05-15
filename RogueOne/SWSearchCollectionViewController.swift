//
//  SWCategoriesCollectionViewController.swift
//  BabyYoda
//
//

import UIKit

class SWCategoriesCollectionViewController: UICollectionViewController {

  private var selectedCategories: SWCategory?
  private lazy var swSearchCollectionDataSource = SWSearchCollectionViewDataSource(delegate: self)
  private var swCategorySearchViewController: SWCategorySearchCollectionViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Star Wars Category"
    configureCollectionView()
  }

  private func configureCollectionView() {
    collectionView.delegate = swSearchCollectionDataSource
    collectionView.dataSource = swSearchCollectionDataSource
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    collectionView.backgroundColor = .lightGray

    let cellNib = UINib(nibName: SWEntityCollectionViewCell.reuseIdentifier, bundle: nil)
    collectionView.register(cellNib, forCellWithReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier)
  }
}

extension SWCategoriesCollectionViewController: SWSearchCollectionViewDataSourceDelegate {

  func presentCategorySearchViewController(_ category: SWCategory) {
    swCategorySearchViewController = SWCategorySearchCollectionViewController(nibName: "SWCategorySearchCollectionViewController", bundle: nil)
    swCategorySearchViewController?.selectedCategory = category
    present(swCategorySearchViewController!, animated: true)
  }
}

