//
//  AdoptView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//

import SwiftUI
struct AdoptView: View {
    
    @State private var _selectedPetType: Pet.PetType = .dogs

    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack {
     
           
            PetTypeView(selectedPetType: $_selectedPetType)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(_selectedPetType.pets) { pet in
                        if(pet.adopting==true){PetView(pet: pet)}
                        
                    }
                }
            }
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
