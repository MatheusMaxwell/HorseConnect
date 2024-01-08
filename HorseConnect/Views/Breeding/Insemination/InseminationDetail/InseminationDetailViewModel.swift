//
//  EmbryoDetailViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 01/12/22.
//

import Foundation
import SwiftUI

final class InseminationDetailViewModel: ObservableObject {
    @Published private(set) var state: InseminationDetailViewState
    private let repository = Repository()
    
    init(initialState: InseminationDetailViewState = .init()){
        self.state = initialState
    }
    
    
    var bindings: (
        openAnimalDetailView: Binding<Bool>,
        showAlertDelete: Binding<Bool>
    ) {
        (
            openAnimalDetailView: Binding(to: \.state.openAnimalDetailView, on: self),
            showAlertDelete: Binding(to: \.state.showAlertDelete, on: self)
        )
    }
    
    func showAlertDeleteToggle(){
        self.state.showAlertDelete = true
    }
    
    func getAnimalById(animalId: String){
        self.state.loading = true
        repository.getAnimalById(animalId: animalId){ animal in
            self.state.animal = animal
            self.state.openAnimalDetailView = true
            self.state.loading = false
        }
    }
    
    func deleteEmbryoById(embryoId: String, complete: @escaping () -> Void){
        self.state.loading = true
        repository.deleteEmbryoById(embryoId: embryoId){
            self.state.loading = false
            complete()
        }
    }
}
