//
//  UIView+Corner.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.
//

import UIKit

extension UIView {
    
    public func roundCorners(
        _ corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner],
        radius: CGFloat = 6) {
        
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}
