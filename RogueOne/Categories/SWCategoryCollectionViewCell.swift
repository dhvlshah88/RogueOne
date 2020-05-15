//
//  SWCategoryCollectionViewCell.swift
//  RogueOne
//
//

import UIKit

class SWCategoryCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "SWCategoryCollectionViewCell"

  @IBOutlet weak var entityColorView: UIView!
  @IBOutlet weak var entityImageView: UIImageView!
  @IBOutlet weak var entityTitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    entityTitleLabel.text = ""
  }

  func configureTitle(_ text: String) {
    entityColorView.backgroundColor = UIColor.random()
    entityTitleLabel.text = text
    entityImageView.image = UIImage(named: text)
  }
}
