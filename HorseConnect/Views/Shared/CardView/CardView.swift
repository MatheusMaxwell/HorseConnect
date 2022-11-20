//
//  CardView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import SwiftUI

struct CardView: View {
    
    var imagePath: String
    var title: String
    var farmData: FarmData?
    var onTapGesture: () -> Void
    
    var body: some View {
        let size = UIScreen.main.bounds.size.width
        return VStack{
            Image(imagePath)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size*0.3, height: size*0.3)
            Text(title)
                .font(.system(size: 30))
                .padding(.bottom, 8)
                .foregroundColor(.white)
        }
        .onTapGesture {
            onTapGesture()
        }
        .frame(width: size*0.45, height: size*0.45)
        .background(ColorUtil.getPrimaryColor(farmData: farmData))
        .cornerRadius(12, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imagePath: "FinanceCardHome", title: "Financeiro"){
            
        }
    }
}
