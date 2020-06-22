//
//  UIView+SnapKit.swift
//  RogueOne
//
//  Created by Dhaval Shah on 6/12/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import Foundation
import SnapKit

extension UIView {

  func addAndAttachEdgesTo(_ parentView: UIView) {
    parentView.addSubview(self)

    self.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }

    forceLayoutIfNeeded()
  }


  func forceLayoutIfNeeded() {
    setNeedsLayout()
    layoutIfNeeded()
  }
}
