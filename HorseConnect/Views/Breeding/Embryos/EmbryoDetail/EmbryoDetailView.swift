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
                AnimalNameDetail(name: embryo.male) {
                    model.getAnimalById(animalId: embryo.maleId)
                }
                Text("X")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                AnimalNameDetail(name: embryo.female) {
                    model.getAnimalById(animalId: embryo.femaleId)
                }
                .padding(.bottom, 40)
                Group{
                    if embryo.receiver.isEmpty == false {
                        TitleDescriptionView(title: "Receptora", description: embryo.receiver)
                    }
                    TitleDescriptionView(title: "Data", description: embryo.date.getDateFromIsoDateString())
                    TitleDescriptionView(title: "Sexo", description: embryo.sex)
                    TitleDescriptionView(title: "Situação", description: embryo.status)
                    TitleDescriptionView(title: "Previsão de parto", description: embryo.date.birthPrediction() ?? "Não disponível")
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
                    secondaryButton: .destructive(Text("Não"))
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
        EmbryoDetailView(embryo: Embryo(female: "Fortune Lumiar", femaleId: "", male: "Lobo Lumiar", maleId: "", receiver: "Tordilha pampa", receiverId: "", date: "2022-12-01T00:35:04Z", userId: "", sex: "Indisponível", status: "A confirmar"))
    }
}
