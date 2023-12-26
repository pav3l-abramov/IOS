//
//  DetailsView.swift
//  PokemonList
//
//  Created by user252252 on 12/20/23.
//


import SwiftUI

struct DetailsView: View {
    let name: String
    @EnvironmentObject var detailsViewModel: PokemonDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader {geo in
            VStack{
                ZStack{
                    
                    ScrollView{
                        VStack(spacing: 10){
                            HStack{
                                Text("Weight").foregroundColor(.gray)
                                Spacer()
                                Text("\(detailsViewModel.pokemonDetails?.weight ?? 0)kg")
                            }
                            HStack{
                                Text("Height").foregroundColor(.gray)
                                Spacer()
                                Text("\(detailsViewModel.pokemonDetails?.height ?? 0)m")
                            }

                        }
                    }.padding(.top).padding(.horizontal,20)
                }
            }
        }
        .navigationTitle(detailsViewModel.pokemonDetails?.name.capitalized ?? "Pokemon Detail")
        .alert(item: $detailsViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle){dismiss()})
        }
        .task{
            await detailsViewModel.getPokemonInfo(name)
        }
    }
    
}
