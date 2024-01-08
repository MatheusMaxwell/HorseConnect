//
//  EmbryoListViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import Foundation
import Combine

final class InseminationListViewModel: ObservableObject {
    
    @Published private(set) var state: InseminationListViewState
    private let repository = Repository()
    
    init(state: InseminationListViewState = .init()){
        self.state = state
    }
    
    
    func getInseminations(){
        self.state.loading = true
        self.repository.getEmbryos(){ embryoList in
            if let embryos = embryoList {
                self.state.inseminations = embryos.filter { $0.receiverId.isEmpty }
            }
            else{
                self.state.showError = true
            }
            self.state.loading = false
        }
    }
}
