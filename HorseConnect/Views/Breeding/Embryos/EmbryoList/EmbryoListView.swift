//
//  EmbryoListView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import SwiftUI

struct EmbryoListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var model = EmbryoListViewModel()
    @State var navigateToEmbryoRegister = false
  
    var body: some View {
        ZStack{
            VStack(alignment: .trailing){
                HStack{
                    Image(systemName: "x.circle.fill")
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Text("Embriões")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                SearchView(searchText: ""){ searchValue in
                    
                }
                Button("+ Novo", action: {
                    navigateToEmbryoRegister.toggle()
                })
                .padding(.trailing)
                NavigationLink(
                    destination: EmbryoRegisterView(),
                    isActive: $navigateToEmbryoRegister,
                    label: {}
                )
                if model.state.embryos.isEmpty{
                    Spacer()
                    Text("Nenhum embrião encontrado.")
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
                                        Text(embryo.receiver + " - " + embryo.date.getDateFromIsoDateString())
                                            .font(.system(size: 15))
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
}

struct EmbryoListView_Previews: PreviewProvider {
    static var previews: some View {
        EmbryoListView()
    }
}
