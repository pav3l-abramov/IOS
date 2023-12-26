//
//  AdoptView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//

import SwiftUI
import Foundation

struct AdoptView: View {
    //var pets: [Pet]
    //@State private var _selectedPetType: Pet.PetType = .dogs
    @ObservedObject var dataManager = DataManager()

    
    var body: some View {
        VStack {

           
           // PetTypeView(selectedPetType: $_selectedPetType)
   
            Text(String(dataManager.myArray.count))
//            List(dataManager){pet in
//                PetView(pet: pet) }
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                    ForEach(pets) { pet in
//                        PetView(pet: pet)
//                        
//                    }
//                }
//            }
            Spacer()
            
        }
        .background(Color.white)
        .navigationBarTitle("", displayMode: .inline)
        

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
