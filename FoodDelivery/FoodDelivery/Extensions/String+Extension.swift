//
//  String+Extension.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
