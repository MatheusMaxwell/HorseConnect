//
//  ProgressView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct AppProgressView: View {
    private var text: String = ""
    private var show: Bool = false
    init(text: String = "", show: Bool){
        self.text = text
        self.show = show
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.6).edgesIgnoringSafeArea(.all)
            ProgressView(text)
        }
        .isHidden(show == false)
    }
}

struct AppProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AppProgressView(text: "Logando...", show: true)
    }
}
