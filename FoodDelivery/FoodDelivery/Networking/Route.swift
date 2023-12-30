//
//  Route.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

enum Route {
    static let baseUrl = "https://yummie.glitch.me"
    //static let baseUrl = "https://www.fruityvice.com/api/fruit/all"
    
    case temp
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    
    var description: String {
        switch self {
        case.temp:
            return ""
        case .fetchAllCategories:
            //return ""
            return "/dish-categories"
        case .placeOrder(let dishId):
            return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId):
            return "/dishes/\(categoryId)"
        case .fetchOrders:
            return "/orders"
        }
    }
}
