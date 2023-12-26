//
//  Pet.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//


import Foundation

protocol Breed {
    var description: String { get }
}

struct Pet: Identifiable {
    
    let id: UUID = UUID()
    let name: String
    let age: Int
    let type: PetType
    let gender: Gender
    let images: [String]
    let breed: Breed
    let weight: Double
    let location: String
    let book:String
    let adopting: Bool
    
    var description: String {
        "The \(name) is a bright, sensitive \( displayType) who enjoys play with his human family and responds well to training. As herders bred to move cattle, they are fearless and independent. They are vigilant watchdogs, with acute senses and a “big dog” bark. Families who can meet their bold but kindly Pembroke’s need for activity and togetherness will never have a more loyal, loving pet."
    }
    
    enum PetType: String, Identifiable, CaseIterable {
        
        var id: String {
            return self.rawValue.capitalized
        }
        
        case dogs, cats, birds, rabbits, hamsters
        
    }
    
    enum Gender: String {
        case male, female
    }
    
    var isAdult: Bool {
        return age > 8
    }
    
    var displayType: String {
        if isAdult { return "Adult" }
        switch type {
        case .birds:
            return "Chick"
        case .dogs:
            return "Puppy"
        case .cats:
            return "Kitten"
        case .rabbits:
            return "Bunny"
        case .hamsters:
            return "Pups"
        }
        
    }
    
    static let dogs = [
        Pet(name: "Bruno", age: 7, type: .dogs, gender: .male, images: ["golden", "golden.1", "golden.2"], breed: DogBreed.golden, weight: 2,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Maya", age: 16, type: .dogs, gender: .female, images: ["maya", "maya.1", "maya.2"], breed: DogBreed.samoyed, weight: 2,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:true),
        Pet(name: "Indra", age: 14, type: .dogs, gender: .female, images: ["shiba", "shiba.1", "shiba.2"], breed: DogBreed.shiba, weight: 4,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Mao", age: 22, type: .dogs, gender: .male, images: ["husky", "husky.1", "husky.2"], breed: DogBreed.husky, weight: 5,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Nora", age: 7, type: .dogs, gender: .male, images: ["corgi.cover"], breed: DogBreed.corgi, weight: 1.5,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Dora", age: 3, type: .dogs, gender: .female, images: ["malamute", "malamute.1"], breed: DogBreed.malamute, weight: 0.8,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        
    ]
    static let cats = [
        Pet(name: "Tou", age: 3, type: .cats, gender: .male, images: ["ragdoll"], breed: CatBreed.ragdoll, weight: 0.5,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Toy", age: 12, type: .cats, gender: .female, images: ["birman", "birman.1"], breed: CatBreed.birman, weight: 3,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:true),
        Pet(name: "Reach", age: 24, type: .cats, gender: .male, images: ["bth"], breed: CatBreed.britishShortHair, weight: 3,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Haru", age: 7, type: .cats, gender: .female, images: ["scottish-fold"], breed: CatBreed.scottishFold, weight: 1.2,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "Pok", age: 18, type: .cats, gender: .female, images: ["sc"], breed: CatBreed.siameseCat, weight: 3,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false),
        Pet(name: "King", age: 22, type: .cats, gender: .male, images: ["pc"], breed: CatBreed.persianCat, weight: 3,location:"Phnom Penh, Cambodia", book:"Tray, food, love",adopting:false)
    ]
}
struct User: Identifiable {
    
    let id: UUID = UUID()
    let name: String
    let phone: String
    let comment: String
    let listAdoption: String
    
    
}

struct Shelter: Identifiable {
    
    let id: UUID = UUID()
    let name: String
    let phone: String
    let comment: String
    let geo: String
    let email:String
    
    
}


enum CatBreed: String, Breed {
    
    var description: String {
        return rawValue.capitalized
    }
    
    case britishShortHair
    case ragdoll
    case birman
    case siameseCat
    case scottishFold
    case persianCat
}

enum DogBreed: String, Breed {
    
    var description: String {
        return rawValue.capitalized
    }
    
    case golden
    case husky
    case samoyed
    case shiba
    case corgi
    case malamute
    
}
