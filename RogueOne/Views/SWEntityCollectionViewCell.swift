//
//  SWEntityCollectionViewCell.swift
//  BabyYoda
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import UIKit

class SWEntityCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "SWEntityCollectionViewCell"

  @IBOutlet weak var entityColorView: UIView!
  @IBOutlet weak var entityTitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    entityTitleLabel.text = ""
  }

  func configure(text: String) {
    entityColorView.backgroundColor = UIColor.random()
    entityTitleLabel.text = text
  }
}
