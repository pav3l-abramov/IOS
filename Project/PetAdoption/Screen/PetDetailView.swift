//
//  PetDetailView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//


import SwiftUI

struct PetDetailView: View {

    @State var currentIndex: Int = 0
    
    let pet: Pet
    
 
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                ZStack(alignment: Alignment.bottom) {
                    PagingView(index: $currentIndex, maxIndex: pet.images.count - 1) {
                        ForEach(pet.images, id:\.self) { image in
                            Image(image)
                                .resizable()
                                .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
                        }
                    }
                    HStack(spacing: 8) {
                        ForEach(0...(pet.images.count - 1), id: \.self) { index in
                            Circle()
                                .fill(currentIndex == index ? Color.primaryColor : Color.primaryDark)
                                .frame(width: currentIndex == index ? 12 : 8, height:  currentIndex == index ? 12 : 8)
                                
                        }
                    }
                    .padding(.bottom, 10)
                
                }.frame(height: 355, alignment: .center)
                
                HStack(spacing: 20) {
                    BoxDetailView(title: "Age", description: "\(pet.age) Months")
                    BoxDetailView(title: "Weight", description: "\(pet.weight) kg")
                    BoxDetailView(title: "Sex", description: pet.gender.rawValue.capitalized)
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(pet.name)
                            .font(.system(size: 18, weight: .medium))
                        Spacer()
                        Text(pet.breed.description)
                            .font(.system(size: 18, weight: .regular))
                    }
                    .padding(.top)
                    
                    
                    HStack {
                        Image("location")
                        Text("Phnom Penh, Cambodia")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    Text("About")
                        .font(.system(size: 18, weight: .medium))
                    
                    Text(pet.description)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                    Spacer().frame(height: 8)
                    Text("Requirements")
                        .font(.system(size: 18, weight: .medium))
                    Text(pet.book)
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(5)
                }
                .foregroundColor(.darkText)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Button(action: {}) {
                    HStack {
                        Text("Adopt")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.primaryColor)
                    .cornerRadius(15)
                }
                
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct BoxDetailView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 14, weight: .regular))
            Text(description)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(10)
        .foregroundColor(.darkText)
        .frame(width: 100, height: 65, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGrey))
    }
}

struct PetDetailPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            PetDetailView(pet: Pet.dogs.first!)
        }
    }
    
}
