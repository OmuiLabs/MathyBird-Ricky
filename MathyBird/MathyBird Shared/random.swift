//
//  random.swift
//  MathyBird iOS
//
//  Created by Ricky Pan on 10/02/23.
//

import Foundation
import CoreGraphics

public extension CGFloat {

    static func random() -> CGFloat{

    return CGFloat(Float(arc4random()) / Float(UInt32.max))
  }
  
    static func random(min : CGFloat, max : CGFloat) -> CGFloat{

    return CGFloat.random() * (max - min) + min
  }
}
