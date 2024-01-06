//
//  ItemHeaderView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 06/01/24.
//

import SwiftUI

struct ItemHeaderView: View {
    var imageName: String
    var title: String
    var dismiss: () -> Void
    
    var body: some View {
        HStack{
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
                .padding(.leading)
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 50)
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.top)
                .foregroundColor(.white)
            Spacer()
        }
    }
}
