//
//  SWSearchCollectionViewDataSource.swift
//  BabyYoda
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import UIKit

protocol SWSearchCollectionViewDataSourceDelegate: class {
  func presentCategorySearchViewController(_ category: SWCategory)
}

class SWSearchCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  private let itemSpacing: CGFloat = 10.0

  let searchCategories = SWCategory.allCases
  private(set) var selectedCategory: SWCategory?
  private weak var delegate: SWSearchCollectionViewDataSourceDelegate?

  init(_ delegate: SWSearchCollectionViewDataSourceDelegate? = nil) {
    self.delegate = delegate
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchCategories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier, for: indexPath) as? SWEntityCollectionViewCell else {
      return UICollectionViewCell()
    }
    let category = searchCategories[indexPath.row]
    swEntityCell.configure(text: category.description)
    return swEntityCell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedCategory = searchCategories[indexPath.row]
    delegate?.presentCategorySearchViewController(selectedCategory)
  }

  // Mark: UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfItems = 2
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

    let totalWidthForCells = collectionView.bounds.width
      - (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItems - 1))
      - (sectionInsets.left + sectionInsets.right)

    let widthPerCell = totalWidthForCells / CGFloat(numberOfItems)
    return CGSize(width: widthPerCell, height: widthPerCell)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return itemSpacing
  }
}
