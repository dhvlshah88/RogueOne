//
//  SWAllCategoryCollectionViewDataSource.swift
//  RogueOne
//
//

import UIKit

protocol SWAllCategoryCollectionViewDataSourceDelegate: class {
  func presentSelectedCategoryViewController(_ categoryType: SWEntityType)
}

class SWAllCategoryCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  private let itemSpacing: CGFloat = 10.0

  let swCategories = SWEntityType.allCases
  private weak var delegate: SWAllCategoryCollectionViewDataSourceDelegate?

  init(delegate: SWAllCategoryCollectionViewDataSourceDelegate? = nil) {
    self.delegate = delegate
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return swCategories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let swEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: SWCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? SWCategoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    let category = swCategories[indexPath.row]
    swEntityCell.configureTitle(category.rawValue)
    return swEntityCell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.presentSelectedCategoryViewController(swCategories[indexPath.row])
  }

  // MARK: UICollectionViewDelegateFlowLayout
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
