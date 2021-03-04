//
//  UIView+Extension.swift
//  SeongnamGift
//
//  Created by heawon on 2021/03/04.
//

import UIKit
extension UIView {
    var width: CGFloat {
           return frame.size.width
       }
       var height: CGFloat {
           return frame.size.height
       }
       var left: CGFloat {
           return frame.origin.x
       }
       var right: CGFloat {
           return left + width
       }
       var top: CGFloat {
           return frame.origin.y
       }
       var bottom: CGFloat {
           return top + height
       }
}
