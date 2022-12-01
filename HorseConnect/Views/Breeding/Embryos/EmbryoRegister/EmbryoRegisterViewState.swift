//
//  EmbryoRegisterViewState.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import Foundation

struct EmbryoRegisterViewState{
    var loading = false
    var animals = [Animal]()
    var showError = false
    var maleSelected = PICKER_EMPTY_STATE
    var femaleSelected = PICKER_EMPTY_STATE
    var receiversSelected = PICKER_EMPTY_STATE
    var sexSelected = EmbryoSex.UNAVAILABLE
    var statusSelected = EmbryoStatus.TO_CONFIRM
    var date = Date()

    var canSubmit: Bool {
        return maleSelected != PICKER_EMPTY_STATE && femaleSelected != PICKER_EMPTY_STATE && receiversSelected != PICKER_EMPTY_STATE
    }
    
    var animalsMale: [Animal]{
        return animals.filter{
            $0.sex == "Macho"
        }
    }
    
    var animalsFemale: [Animal]{
        return animals.filter{
            $0.sex == "Fêmea" && $0.types?.contains(AnimalType.receivers.rawValue) == false
        }
    }
    
    var animalsReceivers: [Animal]{
        return animals.filter{
            $0.types?.contains(AnimalType.receivers.rawValue) == true
        }
    }
}
