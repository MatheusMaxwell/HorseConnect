//
//  TitleDescriptionView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 01/12/22.
//

import SwiftUI

struct TitleDescriptionView: View {
    var title: String
    var description: String
    
    var body: some View {
        HStack{
            Text(title)
            Text(description)
                .foregroundColor(.black.opacity(0.6))
        }
    }
}

struct TitleDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        TitleDescriptionView(title: "Sexo", description: "Macho")
    }
}
