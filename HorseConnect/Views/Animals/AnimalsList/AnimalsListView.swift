//
//  AnimalsListView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import SwiftUI
import CachedAsyncImage

struct AnimalsListView: View {
    @StateObject private var model = AnimalListViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State var navigateToAnimalsRegister = false
    
    var animalType: AnimalType
    
    init(animalType: AnimalType){
        self.animalType = animalType
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .trailing){
                HStack{
                    Image(systemName: "x.circle.fill")
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Text(self.getTitle(animalType: animalType))
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                SearchView(searchText: ""){ searchValue in
                    
                }
                Button("+ Novo", action: {
                    SingletonUtil.shared.animal = nil
                    navigateToAnimalsRegister.toggle()
                })
                .padding(.trailing)
                NavigationLink(
                    destination: AnimalsRegisterView(),
                    isActive: $navigateToAnimalsRegister,
                    label: {}
                )
                if model.state.animals.isEmpty{
                    Spacer()
                    Text("Nenhum animal encontrado.")
                        .foregroundColor(.black.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 150)
                    Spacer()
                }
                else{
                    List{
                        ForEach(model.state.animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)
                                .navigationViewStyle(.stack)) {
                                    HStack{
                                        CachedImageView(imageUrl: animal.imageUrl ?? "", width: 50, height: 50)
                                        VStack(alignment: .leading){
                                            Text(animal.name)
                                            Text(animal.birthDate.getDateFromIsoDateString())
                                                .font(.system(size: 15))
                                                .foregroundColor(.black.opacity(0.6))
                                        }
                                    }
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .onAppear{
                SingletonUtil.shared.animal = nil
                model.getAnimalsByType(animalType: animalType)
            }
            AppProgressView(show: model.state.loading)
        }
       
    }
    
    private func getTitle(animalType: AnimalType?) -> String{
        switch(animalType){
        case .stallion:
            return "Garanhões"
        case .donor:
            return "Doadoras/Matrizes"
        case .foal:
            return "Potros"
        case .competitors:
            return "Competidores"
        case .promises:
            return "Promessas"
        case .gelding:
            return "Castrados"
        case .receivers:
            return "Receptoras"
        case .none:
            return ""
        }
    }
}

struct AnimalsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsListView(animalType: AnimalType.donor)
    }
}
