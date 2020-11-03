//
//  UIViewExt.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 02.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
