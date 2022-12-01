//
//  Embryo.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

struct Embryo: Identifiable {
    
    var id: String?
    var female: String
    var femaleId: String
    var male: String
    var maleId: String
    var receiver: String
    var receiverId: String
    var date: String
    var userId: String
    var sex: String
    var status: String
}

struct EmbryoSex {
    static let UNAVAILABLE = "Indisponível"
    static let MALE = "Macho"
    static let FEMALE = "Fêmea"
}

struct EmbryoStatus {
    static let TO_CONFIRM = "A confirmar"
    static let CONFIRMED = "Confirmado"
}
