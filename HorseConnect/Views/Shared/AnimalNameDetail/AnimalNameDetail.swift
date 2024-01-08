//
//  AnimalNameDetail.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 08/01/24.
//

import SwiftUI

struct AnimalNameDetail: View {
    var name: String
    var onTapGesture: () -> Void
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            Text(name)
                .fontWeight(.bold)
                .font(.system(size: 30))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "arrowshape.right.circle.fill")
                .foregroundColor(.white)
        }
        .onTapGesture {
            onTapGesture()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(ColorUtil.getPrimaryColor(farmData: SingletonUtil.shared.farmData))
        .cornerRadius(12, corners: [.allCorners])
    }
}

#Preview {
    AnimalNameDetail(name: "Teste") {
        
    }
}
