//
//  EmbryoRegisterViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import Foundation
import SwiftUI

final class EmbryoRegisterViewModel: ObservableObject {
    @Published private(set) var state: EmbryoRegisterViewState
    private let repository = Repository()
    
    init(state: EmbryoRegisterViewState = .init()){
        self.state = state
    }
    
    var bindings: (
        femaleSelected: Binding<String>,
        maleSelected: Binding<String>,
        receiversSelected: Binding<String>,
        date: Binding<Date>
    ) {
        (
            femaleSelected: Binding(to: \.state.femaleSelected, on: self),
            maleSelected: Binding(to: \.state.maleSelected, on: self),
            receiversSelected: Binding(to: \.state.receiversSelected, on: self),
            date: Binding(to: \.state.date, on: self)
        )
    }
    
    func getAnimals(){
        self.state.loading = true
        
        self.repository.getAnimals(){ animalsRepository in
            DispatchQueue.main.async {
                if let animals = animalsRepository {
                    self.state.animals = animals
                }
                else{
                    self.state.animals = []
                    self.state.showError = true
                }
                self.state.loading = false
            }
        }
    }
    
    func createEmbryo(complete: @escaping () -> Void){
        self.state.loading = true
        let femaleId = self.state.animals.first{ $0.name == self.state.femaleSelected}?.id  ?? ""
        let maleId = self.state.animals.first{ $0.name == self.state.maleSelected}?.id ?? ""
        let receiverId = self.state.animals.first{ $0.name == self.state.receiversSelected}?.id ?? ""
        let embryo = Embryo(female: self.state.femaleSelected, femaleId: femaleId, male: self.state.maleSelected, maleId: maleId, receiver: self.state.receiversSelected, receiverId: receiverId, date: self.state.date.ISO8601Format(), userId: SingletonUtil.shared.userUid)
        
        self.repository.addEmbryo(embryo: embryo) {
            DispatchQueue.main.async {
                self.state.loading = false
                complete()
            }
        }
    }
}
