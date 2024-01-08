//
//  EmbryoRegisterViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import Foundation
import SwiftUI

final class InseminationRegisterViewModel: ObservableObject {
    @Published private(set) var state: InseminationRegisterViewState
    private let repository = Repository()
    
    init(state: InseminationRegisterViewState = .init()){
        self.state = state
    }
    
    var bindings: (
        femaleSelected: Binding<String>,
        maleSelected: Binding<String>,
        date: Binding<Date>,
        sexSelected: Binding<String>,
        statusSelected: Binding<String>
    ) {
        (
            femaleSelected: Binding(to: \.state.femaleSelected, on: self),
            maleSelected: Binding(to: \.state.maleSelected, on: self),
            date: Binding(to: \.state.date, on: self),
            sexSelected: Binding(to: \.state.sexSelected, on: self),
            statusSelected: Binding(to: \.state.statusSelected, on: self)
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
    
    func createInsemination(complete: @escaping () -> Void){
        self.state.loading = true
        let femaleId = self.state.animals.first{ $0.name == self.state.femaleSelected}?.id  ?? ""
        let maleId = self.state.animals.first{ $0.name == self.state.maleSelected}?.id ?? ""
        let embryo = Embryo(female: self.state.femaleSelected, femaleId: femaleId, male: self.state.maleSelected, maleId: maleId, receiver: "", receiverId: "", date: self.state.date.ISO8601Format(), userId: SingletonUtil.shared.userUid, sex: self.state.sexSelected, status: self.state.statusSelected)
        
        self.repository.addEmbryo(embryo: embryo) {
            DispatchQueue.main.async {
                self.state.loading = false
                complete()
            }
        }
    }
}
