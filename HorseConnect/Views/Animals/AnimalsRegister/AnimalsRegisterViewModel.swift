//
//  AnimalsRegisterViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import Combine
import Foundation
import SwiftUI

class AnimalsRegisterViewModel: ObservableObject {
    
    @Published private(set) var state = AnimalsRegisterViewState()
    
    var bindings: (
        animalName: Binding<String>,
        animalImageUrl: Binding<String>,
        birthDateAnimal: Binding<Date>,
        coatAnimal: Binding<String>,
        sexAnimal: Binding<String>,
        isLiveAnimal: Binding<Bool>,
        types: Binding<[String]>,
        loading: Binding<Bool>,
        imageSelected: Binding<UIImage>,
        showGalleryToSelectImage: Binding<Bool>
    ) {
        (
            animalName: Binding(to: \.state.animalName, on: self),
            animalImageUrl: Binding(to: \.state.animalImageUrl, on: self),
            birthDateAnimal: Binding(to: \.state.birthDateAnimal, on: self),
            coatAnimal: Binding(to: \.state.coatAnimal, on: self),
            sexAnimal: Binding(to: \.state.sexAnimal, on: self),
            isLiveAnimal: Binding(to: \.state.isLiveAnimal, on: self),
            types: Binding(to: \.state.types, on: self),
            loading: Binding(to: \.state.loading, on: self),
            imageSelected: Binding(to: \.state.imageSelected, on: self),
            showGalleryToSelectImage: Binding(to: \.state.showGalleryToSelectImage, on: self)
        )
    }
    
    func createAnimal(){
        
    }
    
    
    func addOrRemoveItem(type: String){
        if self.state.types.contains(type) {
            self.state.types.removeAll(where: { $0 == type })
        } else {
            self.state.types.append(type)
        }
    }
}
