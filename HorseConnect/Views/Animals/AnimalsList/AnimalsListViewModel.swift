//
//  AnimalsListViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import Combine
import Foundation
import SwiftUI

class AnimalListViewModel: ObservableObject {
    
    @Published private(set) var state: AnimalListViewState
    private let repository = Repository()
    
    init(state: AnimalListViewState = .init()) {
        self.state = state
    }
    
    var bindings: (
        loading: Binding<Bool>,
        showError: Binding<Bool>
    ) {
        (
            loading: Binding(to: \.state.loading, on: self),
            showError: Binding(to: \.state.showError, on: self)
        )
    }
    
    func getAnimalsByType(animalType: AnimalType){
        self.state.loading = true
        DispatchQueue.main.async {
            let userId = SingletonUtil.shared.userUid
            self.repository.getAnimals(userId: userId){ animalsRepository in
                if let animals = animalsRepository {
                    self.state.animals = animals.filter{ $0.types?.contains(animalType.rawValue) ?? false}
                    self.state.loading = false
                }
                else{
                    self.state.animals = []
                    self.state.loading = false
                    self.state.showError = true
                }
            }
        }
    }
    
}
