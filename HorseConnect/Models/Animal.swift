//
//  Animal.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

struct Animal : Identifiable {
    var id: String?
    var name: String
    var imageId: String?
    var imageUrl: String?
    var birthDate: String
    var coat: String //Pelagem
    var sex: String
    var isLive: Bool
    var types: [String]?
    var userId: String
}

enum AnimalType: String {
    //Garanhao, doadoras, potros, competidores, promessas, castrados, receptoras
    case stallion, donor, foal, competitors, promises, gelding, receivers
}

