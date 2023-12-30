//
//  Order.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
