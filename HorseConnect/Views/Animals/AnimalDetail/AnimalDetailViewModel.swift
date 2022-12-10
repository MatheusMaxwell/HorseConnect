//
//  AnimalDetailViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/12/22.
//

import Foundation
import SwiftUI

final class AnimalDetailViewModel: ObservableObject {
    @Published private(set) var state = AnimalDetailViewState()
    private let repository = Repository()
    
    var bindings: (
        loading: Binding<Bool>,
        showAlertDelete: Binding<Bool>
    ) {
        (
            loading: Binding(to: \.state.loading, on: self),
            showAlertDelete: Binding(to: \.state.showAlertDelete, on: self)
        )
    }
    
    
    func showAlertDeleteToggle(){
        self.state.showAlertDelete = true
    }
    
    func deleteAnimalById(animalId: String, complete: @escaping () -> Void){
        self.state.loading = true
        repository.deleteAnimalById(animalId: animalId){
            self.state.loading = false
            complete()
        }
    }
    
}
