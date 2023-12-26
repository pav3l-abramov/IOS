//
//  AdoptPet.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//

import Foundation
protocol PetDelegate {
    func addNewPet(_ pet: Pet)
    
}

class DataManager: ObservableObject {
    @Published var myArray = []
}
