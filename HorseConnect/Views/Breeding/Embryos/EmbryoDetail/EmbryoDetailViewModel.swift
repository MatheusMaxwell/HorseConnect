//
//  EmbryoDetailViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 01/12/22.
//

import Foundation
import SwiftUI

final class EmbryoDetailViewModel: ObservableObject {
    @Published private(set) var state: EmbryoDetailViewState
    private let repository = Repository()
    
    init(initialState: EmbryoDetailViewState = .init()){
        self.state = initialState
    }
    
    var bindingOpenAnimalDetailView: Binding<Bool> {
        Binding(to: \.state.openAnimalDetailView, on: self)
    }
    
    func getAnimalById(animalId: String){
        self.state.loading = true
        repository.getAnimalById(animalId: animalId){ animal in
            self.state.animal = animal
            self.state.openAnimalDetailView = true
            self.state.loading = false
        }
    }
}
