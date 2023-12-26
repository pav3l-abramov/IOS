//
//  ShelterView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//

import SwiftUI
struct ShelterView: View {
   
    @State private var _selectedPetType: Pet.PetType = .dogs

    let shelter = Shelter(name: "The Cat House on the Kings", phone: "(559) 638-8696", comment: "The Cat House on the Kings is California's largest no-cage, no-kill, lifetime cat sanctuary and adoption center. Our mission is to place rescued cats and kittens into loving, permanent homes; to provide a safe, happy and healthy home for unwanted cats and kittens in a unique, no-cage facility; to prevent pet overpopulation through spaying and neutering; and to educate the public about responsible pet ownership.", geo: "7120 S Kings River Rd, Parlier, CA 93648, Vereinigte Staaten", email: "ask@animalcouriers.com")
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    var body: some View {
        ScrollView (.vertical) {
        // HStack(spacing: 8) {
         Image("Shelter")
             .resizable()
             .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
         Spacer()
                 VStack(alignment: .leading, spacing: 10) {
                     Text("name:")
                         .font(.system(size: 18, weight: .medium))
                     Text(shelter.name)
                         .font(.system(size: 16, weight: .regular))
                         .lineSpacing(5)
                     Spacer().frame(height: 8)
                     Text("phone:")
                         .font(.system(size: 18, weight: .medium))
                     
                     Text(shelter.phone)
                         .font(.system(size: 16, weight: .regular))
                         .lineSpacing(5)
                     Spacer().frame(height: 8)
                     
                     Text("email:")
                         .font(.system(size: 18, weight: .medium))
                     
                     Text(shelter.email)
                         .font(.system(size: 16, weight: .regular))
                         .lineSpacing(5)
                     Spacer().frame(height: 8)
                     Text("comment:")
                         .font(.system(size: 18, weight: .medium))
                     
                     Text(shelter.comment)
                         .font(.system(size: 16, weight: .regular))
                         .lineSpacing(5)
                     Spacer().frame(height: 8)
                     Text("Adress:")
                         .font(.system(size: 18, weight: .medium))
                     
                     Text(shelter.geo)
                         .font(.system(size: 16, weight: .regular))
                         .lineSpacing(5)
//                     TextField("Title", text: $text,  axis: .vertical)
//                         .lineLimit(5...10)
                     
                 }
                 .foregroundColor(.darkText)
                 .padding()
                 .frame(maxWidth: .infinity, alignment: .leading)


             
         }

     }
    
}

private extension Pet.PetType {
    
    var pets: [Pet] {
        switch self {
        case .dogs:
            return Pet.dogs
        case .cats:
            return Pet.cats
        default:
            return []
        }
    }
    
}
