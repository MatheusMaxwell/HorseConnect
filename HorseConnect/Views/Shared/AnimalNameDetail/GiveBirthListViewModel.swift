//
//  GiveBirthListViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 08/01/24.
//

import Foundation
import Combine

final class GiveBirthListViewModel: ObservableObject {
    
    @Published private(set) var state: GiveBirthListViewState
    private let repository = Repository()
    
    init(state: GiveBirthListViewState = .init()){
        self.state = state
    }
    
    
    func getEmbryos(){
        self.state.loading = true
        self.repository.getEmbryos(){ embryoList in
            if let embryos = embryoList {
                self.state.embryos = embryos
            }
            else{
                self.state.showError = true
            }
            self.state.loading = false
        }
    }
}
