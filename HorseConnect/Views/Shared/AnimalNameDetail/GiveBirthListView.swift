//
//  EmbryoListView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import SwiftUI

struct GiveBirthListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var model = GiveBirthListViewModel()
  
    var body: some View {
        ZStack{
            VStack(alignment: .trailing){
                HStack{
                    Image(systemName: "x.circle.fill")
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Text("Partos")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                SearchView(searchText: ""){ searchValue in
                    
                }
                if model.state.embryos.isEmpty{
                    Spacer()
                    Text("Nenhum parto encontrado.")
                        .foregroundColor(.black.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 150)
                    Spacer()
                }
                else{
                    List{
                        ForEach(model.state.embryos) { embryo in
                            NavigationLink(destination: EmbryoDetailView(embryo: embryo)
                                .navigationViewStyle(.stack)) {
                                    VStack(alignment: .leading){
                                        Text(embryo.male + " x " + embryo.female)
                                        Text(getEmbryoDesc(embryo: embryo))
                                            .font(.system(size: 15))
                                            .foregroundColor(.black.opacity(0.6))
                                        Text("Previsão " + (embryo.date.birthPrediction() ?? "não disponível"))
                                            .font(.system(size: 18))
                                            .foregroundColor(.black.opacity(0.6))
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .onAppear{
                self.model.getEmbryos()
            }
            AppProgressView(show: model.state.loading)
        }
       
    }
    
    private func getEmbryoDesc(embryo: Embryo) -> String {
        var desc = embryo.date.getDateFromIsoDateString()
        if embryo.receiver.isEmpty == false {
            desc += " - Receptora " + embryo.receiver
        }
        
        return desc
    }
}

struct GiveBirthListView_Previews: PreviewProvider {
    static var previews: some View {
        GiveBirthListView()
    }
}
