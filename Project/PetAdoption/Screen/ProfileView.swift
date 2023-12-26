//
//  ProfileView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//

import SwiftUI
struct ProfileView: View {
    
    @State private var _selectedPetType: Pet.PetType = .dogs
    let user = User(name: "Pavel",phone: "88005553535",comment: "no Comment",listAdoption: "list adoption")
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {

       // HStack(spacing: 8) {
        Image("Profile")
            .resizable()
            .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
        Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("name:")
                        .font(.system(size: 18, weight: .medium))
                    Text(user.name)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                    Spacer().frame(height: 8)
                    Text("phone:")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text(user.phone)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                    Spacer().frame(height: 8)
                    Text("comment:")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text(user.comment)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                    Spacer().frame(height: 8)
                    Text("adoption list:")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text(user.listAdoption)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                    
                }
                .foregroundColor(.darkText)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)


            
       // }

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
