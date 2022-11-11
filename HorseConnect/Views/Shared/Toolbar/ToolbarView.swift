//
//  ToolbarView.swift
//  Genio Forms
//
//  Created by ICARO CAMPOS on 23/09/22.
//

import SwiftUI

struct ToolbarView: ToolbarContent {
    @StateObject private var model = ToolbarViewModel()
    
//    init() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = UIColor(Color.primaryColor)
//        UINavigationBar.appearance().backgroundColor = UIColor(Color.primaryColor)
//    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading){
            Image("HorseConnect").resizable().frame(width: 70.0, height: 40.0)
        }
        ToolbarItem(placement: .navigationBarTrailing){
            Menu {
                Button("Sair", action: model.isLoggedOutToggle)
                
            } label: {
                Image(systemName: "ellipsis").tint(Color.white).rotationEffect(.degrees(-90))
                
            }
            .alert(isPresented: model.bindingIsLoggedOut) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Deseja realmente sair?"),
                    primaryButton: .destructive(Text("Sim")) {
                        model.logout()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

