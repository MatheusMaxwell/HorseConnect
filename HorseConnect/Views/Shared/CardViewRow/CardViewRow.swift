//
//  CardViewRow.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 29/11/22.
//

import SwiftUI

struct CardViewRow: View {
    var imagePath: String
    var title: String
    var farmData: FarmData?
    var onTapGesture: () -> Void
    
    var body: some View {
        let size = UIScreen.main.bounds.size.width
        return HStack{
            Image(imagePath)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(title)
                .font(.system(size: 30))
                .foregroundColor(.white)
            Spacer()
        }
        .onTapGesture {
            onTapGesture()
        }
        .frame(width: size*0.9, height: size*0.25)
        .background(ColorUtil.getPrimaryColor(farmData: farmData))
        .cornerRadius(12, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
    }
}

struct CardViewRow_Previews: PreviewProvider {
    static var previews: some View {
        CardViewRow(imagePath: "FinanceCardHome", title: "Financeiro"){
            
        }
    }
}
