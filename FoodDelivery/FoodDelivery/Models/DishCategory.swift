//
//  DishCategory.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct DishCategory: Decodable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
