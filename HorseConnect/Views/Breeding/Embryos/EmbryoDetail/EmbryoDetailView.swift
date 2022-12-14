//
//  EmbryoDetailView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 01/12/22.
//

import SwiftUI

struct EmbryoDetailView: View {
    var embryo: Embryo
    @StateObject private var model = EmbryoDetailViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Image(systemName: "trash.fill")
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        model.showAlertDeleteToggle()
                    }
                    .padding(.bottom, 10)
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
                .onTapGesture {
                    model.getAnimalById(animalId: embryo.maleId)
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
                .onTapGesture {
                    model.getAnimalById(animalId: embryo.femaleId)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.gray)
                .cornerRadius(12, corners: [.allCorners])
                Group{
                    TitleDescriptionView(title: "Receptora", description: embryo.receiver)
                        .padding(.top, 40)
                    TitleDescriptionView(title: "Data", description: embryo.date.getDateFromIsoDateString())
                    TitleDescriptionView(title: "Sexo", description: embryo.sex)
                    TitleDescriptionView(title: "Situa????o", description: embryo.status)
                }
                Spacer()
                if model.state.animal != nil {
                    NavigationLink(
                        destination: AnimalDetailView(animal: model.state.animal!),
                        isActive: model.bindings.openAnimalDetailView,
                        label: {}
                    )
                }
                
            }
            .alert(isPresented: model.bindings.showAlertDelete){
                Alert(
                    title: Text("Deletar"),
                    message: Text("Deseja realmente deletar?"),
                    primaryButton: .default(Text("Sim")){
                        if let embryoId = embryo.id {
                            model.deleteEmbryoById(embryoId: embryoId){
                                self.dismiss()
                            }
                        }
                    },
                    secondaryButton: .destructive(Text("N??o"))
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            AppProgressView(show: model.state.loading)
        }
        
    }
}

struct EmbryoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmbryoDetailView(embryo: Embryo(female: "Fortune Lumiar", femaleId: "", male: "Lobo Lumiar", maleId: "", receiver: "Tordilha pampa", receiverId: "", date: "2022-12-01T00:35:04Z", userId: "", sex: "Indispon??vel", status: "A confirmar"))
    }
}
