//
//  ApiResponse.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
