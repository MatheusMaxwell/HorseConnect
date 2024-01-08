//
//  EmbryoListView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import SwiftUI

struct InseminationListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var model = InseminationListViewModel()
    @State var navigateToInseminationRegister = false
  
    var body: some View {
        ZStack{
            VStack(alignment: .trailing){
                HStack{
                    Image(systemName: "x.circle.fill")
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Text("Inseminações/Cobrições")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                SearchView(searchText: ""){ searchValue in
                    
                }
                Button("+ Novo", action: {
                    navigateToInseminationRegister.toggle()
                })
                .padding(.trailing)
                NavigationLink(
                    destination: InseminationRegisterView(),
                    isActive: $navigateToInseminationRegister,
                    label: {}
                )
                if model.state.inseminations.isEmpty{
                    Spacer()
                    Text("Nenhuma inseminação/cobrição encontrada.")
                        .foregroundColor(.black.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 150)
                    Spacer()
                }
                else{
                    List{
                        ForEach(model.state.inseminations) { embryo in
                            NavigationLink(destination: InseminationDetailView(embryo: embryo)
                                .navigationViewStyle(.stack)) {
                                    VStack(alignment: .leading){
                                        Text(embryo.male + " x " + embryo.female)
                                        Text(embryo.date.getDateFromIsoDateString())
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
                self.model.getInseminations()
            }
            AppProgressView(show: model.state.loading)
        }
       
    }
}

struct InseminationListView_Previews: PreviewProvider {
    static var previews: some View {
        InseminationListView()
    }
}
