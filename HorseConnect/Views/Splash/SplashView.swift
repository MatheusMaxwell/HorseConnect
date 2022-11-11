//
//  SplashView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject private var model: SplashViewModel

    init(model: SplashViewModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack{
            Color.primaryColor.ignoresSafeArea(.all)
            Image("HorseConnect")
                .aspectRatio(contentMode: .fit)
            NavigationLink(
                destination: LoginView(model: .init()),
                isActive: model.bindings.callLogin,
                label: {}
            )
            NavigationLink(
                destination: HomeView(),
                isActive: model.bindings.callHome,
                label: {}
            )
        }
        .onAppear{
            model.callLoginOrHome()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(model: .init(initialState: .init()))
    }
}
