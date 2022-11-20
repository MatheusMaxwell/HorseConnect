//
//  AnimalsRegisterViewState.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import Foundation
import UIKit

struct AnimalsRegisterViewState {
    var animal: Animal? = nil
    var animalName = ""
    var animalImageUrl = ""
    var birthDateAnimal = Date()
    var coatAnimal = ""
    var sexAnimal = ""
    var isLiveAnimal = true
    var types = [String]()
    var loading = false
    var imageSelected = UIImage()
    var showGalleryToSelectImage = false
}

extension AnimalsRegisterViewState {
    
    var canSubmit: Bool {
        return animalName.isEmpty == false && types.count > 0
    }
    
}

