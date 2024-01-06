//
//  AnimalsHomeView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import SwiftUI

struct AnimalsHomeView: View {
    
    @Environment(\.dismiss) var dismiss
    private var farmData: FarmData? = nil
    @State var navigateToAnimalsList = false
    @State var animalType: AnimalType? = nil
    
    init(){
        farmData = SingletonUtil.shared.farmData
    }
    
    var body: some View {
        ZStack{
            ColorUtil
                .getPrimaryColor(farmData: farmData)
                .ignoresSafeArea(.all)
            VStack{
                ItemHeaderView(imageName: "HorseCardHome", title: "Plantel", dismiss: { self.dismiss() })
                VStack {
                    List {
                        CardViewRow(imagePath: "garanhao", title: "Garanhões", farmData: farmData){
                            self.navigate(animalType: AnimalType.stallion)
                        }
                        CardViewRow(imagePath: "doadoras", title: "Doadoras\nMatrizes", farmData: farmData){
                            self.navigate(animalType: AnimalType.donor)
                        }

                    
                    
                        CardViewRow(imagePath: "potro", title: "Potros", farmData: farmData){
                            self.navigate(animalType: AnimalType.foal)
                        }
                        CardViewRow(imagePath: "competidores", title: "Competidores", farmData: farmData){
                            self.navigate(animalType: AnimalType.competitors)
                        }
                           
                    
                    
                        CardViewRow(imagePath: "promessas", title: "Promessas", farmData: farmData){
                            self.navigate(animalType: AnimalType.promises)
                        }
                        CardViewRow(imagePath: "castrado", title: "Castrados", farmData: farmData){
                            self.navigate(animalType: AnimalType.gelding)
                        }

                    
                    
                        CardViewRow(imagePath: "receptoras", title: "Receptoras", farmData: farmData){
                            self.navigate(animalType: AnimalType.receivers)
                        }
                    }
                    .listStyle(.plain)
                }
                .background()
                .cornerRadius(12, corners: [.topLeft, .topRight])
                
            }
            .sheet(isPresented: $navigateToAnimalsList){
                NavigationView{
                    if let type = animalType {
                        AnimalsListView(animalType: type)
                    }
                }
                .navigationViewStyle(.stack)
            } 
        }
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, -40)
    }
    
    private func navigate(animalType: AnimalType){
        self.animalType = animalType
        navigateToAnimalsList = true
    }
}

struct AnimalsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsHomeView()
    }
}
