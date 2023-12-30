
//
//  UIView+Extension.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
