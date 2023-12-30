//
//  AllDishes.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct AllDishes: Decodable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
