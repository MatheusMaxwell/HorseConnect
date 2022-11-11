//
//  SplashViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI
import FirebaseAuth

final class SplashViewModel: ObservableObject {
    
    @Published private(set) var state: SplashViewState
    private let auth = Auth.auth()
    
    init(initialState: SplashViewState = .init()) {
        state = initialState
    }
    
    var bindings: (
            callLogin: Binding<Bool>,
            callHome: Binding<Bool>
        ) {
            (
                callLogin: Binding(to: \.state.callLogin, on: self),
                callHome: Binding(to: \.state.callHome, on: self)
            )
        }
    
    func callLoginOrHome(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            if self.auth.currentUser != nil {
                SingletonUtil.shared.userUid = self.auth.currentUser?.uid ?? ""
                self.state.callHome = true
            }
            else{
                self.state.callLogin = true
            }
        }
    }
    
}
