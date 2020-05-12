//
//  UIColor+Random.swift
//  RogueOne
//
//  Created by Dhaval Shah on 5/3/20.
//  Copyright © 2020 Dhaval Shah. All rights reserved.
//

import UIKit

extension UIColor {
  static func random() -> UIColor {
    let hue = CGFloat(arc4random() % 256) / 256
    let saturation = CGFloat(arc4random() % 128) / 256 + 0.5
    let brightness = CGFloat(arc4random() % 128) / 256 + 0.5
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
  }
}
