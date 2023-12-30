//
//  Provider.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation

struct Provider: Decodable {
    var name: String = "OAO VegetablesAndFruits"
    var logo: String = "provider"
    var description: String = "We purchase many vegetables, including carrots, tomatoes, bell peppers, onions, garlic, potatoes, horseradish, chickpeas and spinach. To ensure the vegetables we source are sustainably produced, we are working with farmers through our suppliers to develop practices that protect and enhance biodiversity and respect labor rights."
    var phone: String = "+79045012342"
    var eMail: String = "oaovegetables@gmail.com"
    var site: String = "https://www.greenyard.group/divisions/fresh"
    var rating: Int = 5
    
    var formattedRating: String {
        return "\(rating)/5 stars"
    }

    
}
