//
//  EmbryoListViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import Foundation
import Combine

final class EmbryoListViewModel: ObservableObject {
    
    @Published private(set) var state: EmbryoListViewState
    private let repository = Repository()
    
    init(state: EmbryoListViewState = .init()){
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
