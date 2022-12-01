//
//  EmbryoDetailView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 01/12/22.
//

import SwiftUI

struct EmbryoDetailView: View {
    var embryo: Embryo
    
    var body: some View {
        VStack(alignment: .leading){
            Image(systemName: "square.and.pencil")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                
                }
                .padding(.bottom, 40)
            HStack(alignment: .center){
                Text(embryo.male)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.gray)
            .cornerRadius(12, corners: [.allCorners])
            Text("X")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            HStack(alignment: .center){
                Text(embryo.female)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.gray)
            .cornerRadius(12, corners: [.allCorners])
            
            TitleDescriptionView(title: "Receptora", description: embryo.receiver)
                .padding(.top, 40)
            TitleDescriptionView(title: "Data", description: embryo.date.getDateFromIsoDateString())
            TitleDescriptionView(title: "Sexo", description: embryo.sex)
            TitleDescriptionView(title: "Situação", description: embryo.status)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmbryoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmbryoDetailView(embryo: Embryo(female: "Fortune Lumiar", femaleId: "", male: "Lobo Lumiar", maleId: "", receiver: "Tordilha pampa", receiverId: "", date: "2022-12-01T00:35:04Z", userId: "", sex: "Indisponível", status: "A confirmar"))
    }
}
