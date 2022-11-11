//
//  HomeViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import SwiftUI

final class HomeViewModel: ObservableObject{
    
    @Published private(set) var state: HomeViewState
    private let repository = Repository()
    
    init(
        initialState: HomeViewState = .init()
    ) {
        state = initialState
    }
    
    var bindings: (
            showError: Binding<Bool>,
            loading: Binding<Bool>
        ) {
            (
                showError: Binding(to: \.state.showError, on: self),
                loading: Binding(to: \.state.loading, on: self)
            )
        }
    
    func getFarmData(userId: String){
        state.loading = true
        DispatchQueue.main.async {
            self.repository.getFarmData(userId: userId){ farmData in
                if farmData != nil {
                    self.state.farmData = farmData
                }
                else{
                    self.state.farmData = farmData
                    self.state.showError = true
                    self.state.messageError = "Ocorreu um erro ao tentar recuperar os dados da sua propriedade."
                }
                self.state.loading = false
            }
        }
    }
}
