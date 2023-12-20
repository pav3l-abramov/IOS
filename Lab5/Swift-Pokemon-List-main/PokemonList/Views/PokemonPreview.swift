//
//  PokemonPreview.swift
//  PokemonList
//
//  Created by user252252 on 12/20/23.
//

import SwiftUI

struct PokemonPixelView: View {
    let id: Int
    let cellSize: Double
    let name: String
    @Binding var selection: String?
    
    var body: some View {
        VStack {            
            Text("\(name.capitalized)")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
    
        }
        .foregroundColor(.primary)
        .onTapGesture {
            self.selection = name
        }
        .padding([.top, .horizontal],20)
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
