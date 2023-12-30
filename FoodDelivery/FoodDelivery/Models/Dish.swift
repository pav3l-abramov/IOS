//
//  Dish.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct Dish: Decodable {
    let id, name, description, image: String?
    let calories: Int?
    let price: Float = 119.50
    let prvd: Provider = Provider()
    
    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
    var formattedPrice: String {
        return "  \(price ) $"
    }
    
}
