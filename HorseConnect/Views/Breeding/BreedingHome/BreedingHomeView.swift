//
//  BreedingHomeView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 29/11/22.
//

import SwiftUI

enum NavigateDestinationBreedingHome {
    case animals, embryos, inseminations, giveBirth
}

struct BreedingHomeView: View {
    @Environment(\.dismiss) var dismiss
    private var farmData: FarmData? = nil
    @State var navigate = false
    @State var navigateDestination: NavigateDestinationBreedingHome? = nil
    
    init(){
        farmData = SingletonUtil.shared.farmData
    }
    
    var body: some View {
        ZStack{
            ColorUtil
                .getPrimaryColor(farmData: farmData)
                .ignoresSafeArea(.all)
            VStack{
                HStack{
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Image("StationCardHome")
                        .resizable()
                        .frame(width: 100, height: 80)
                        .aspectRatio(contentMode: .fit)
                    Text("Estação")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                
                VStack{
                    List{
                        CardViewRow(imagePath: "embryo", title: "Embriões", farmData: farmData){
                            navigateDestination = .embryos
                            navigate.toggle()
                        }
                        CardViewRow(imagePath: "insemination", title: "Inseminação", farmData: farmData){
                            
                        }
                        CardViewRow(imagePath: "giveBirth", title: "Partos", farmData: farmData){
                            
                        }
                        
                        CardViewRow(imagePath: "HorseCardHome", title: "Animais usados de fora", farmData: farmData){
                            navigateDestination = .animals
                            navigate.toggle()
                        }
                    }
                    .listStyle(.plain)
                }
                .background()
                .cornerRadius(12, corners: [.topLeft, .topRight])
            }
            
        }
        .sheet(isPresented: $navigate){
            NavigationView{
                if let destination = navigateDestination {
                    switch(destination){
                        case .animals: AnimalsListView(animalType: AnimalType.animalOutside)
                        case .embryos: EmbryoListView()
                        case .inseminations: AnimalsListView(animalType: AnimalType.animalOutside)
                        case .giveBirth: AnimalsListView(animalType: AnimalType.animalOutside)
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, -40)
    }  
}

struct BreedingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BreedingHomeView()
    }
}
