//
//  UIView+Extension.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 04.10.2021.
//

import UIKit

extension UIView{
    func roundCorners(corners: CACornerMask, radius: CGFloat, differentCorner: CACornerMask, secondCornerRadius: CGFloat) {
        
        let layer = CALayer()
        layer.frame = self.frame
        layer.cornerRadius = secondCornerRadius
        layer.maskedCorners = differentCorner
        self.layer.addSublayer(layer)
        layer.masksToBounds = false
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = radius
     }
}
