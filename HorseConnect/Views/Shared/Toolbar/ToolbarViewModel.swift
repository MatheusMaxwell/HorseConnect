//
//  ToolbarViewModel.swift
//  Genio Forms
//
//  Created by ICARO CAMPOS on 23/09/22.
//

import SwiftUI
import FirebaseAuth

final class ToolbarViewModel: ObservableObject {
    
    @Published private(set) var state: ToolbarViewState
    private let auth = Auth.auth()
    private let dataController = DataController.shared
    
    init(initialState: ToolbarViewState = .init()) {
        state = initialState
    }
    
    var bindingIsLoggedOut : Binding<Bool> {
        Binding(to: \.state.isLoggedOut, on: self)
    }

    func logout(){
        do{
            try auth.signOut()
            SingletonUtil.shared.farmData = nil
            SingletonUtil.shared.userUid = ""
            dataController.clearAllData()
            NavigationUtil.popToRootView()
        }catch let error as NSError {
            print(error)
        }
        
        
    }
    
    func isLoggedOutToggle(){
        self.state.isLoggedOut.toggle()
    }
}
