//
//  SWEntityCollectionViewCell.swift
//  RogueOne
//
//

import UIKit

class SWEntityCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "SWEntityCollectionViewCell"

  @IBOutlet weak var blurEffectView: UIVisualEffectView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var entityImageView: UIImageView!
  @IBOutlet weak var entityTitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    entityTitleLabel.text = ""
    containerView.backgroundColor = UIColor.random()
  }

  func configure(text: String, imageName: String) {
    entityTitleLabel.text = text
    entityImageView.image = UIImage(named: imageName) ?? nil
  }
}
