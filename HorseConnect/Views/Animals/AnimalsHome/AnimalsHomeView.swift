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
                HStack{
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .onTapGesture {
                            self.dismiss()
                        }
                    Spacer()
                    Image("HorseCardHome")
                        .resizable()
                        .frame(width: 100, height: 80)
                        .aspectRatio(contentMode: .fit)
                    Text("Plantel")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.top)
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack{
                    List{
                        VStack(alignment: .leading){
                            HStack{
                                CardView(imagePath: "garanhao", title: "Garanhões", farmData: farmData){
                                    self.navigate(animalType: AnimalType.stallion)
                                }
                                    .padding(.trailing, 5)
                                    
                                CardView(imagePath: "doadoras", title: "Doadoras\nMatrizes", farmData: farmData){
                                    self.navigate(animalType: AnimalType.donor)
                                }
                                    .padding(.leading, 5)
                                    

                            }
                            HStack{
                                CardView(imagePath: "potro", title: "Potros", farmData: farmData){
                                    self.navigate(animalType: AnimalType.foal)
                                }
                                    .padding(.trailing, 5)
                                    .padding(.top)
                                CardView(imagePath: "competidores", title: "Competidores", farmData: farmData){
                                    self.navigate(animalType: AnimalType.competitors)
                                }
                                    .padding(.leading, 5)
                                    .padding(.top)
                                   
                            }
                            HStack{
                                CardView(imagePath: "promessas", title: "Promessas", farmData: farmData){
                                    self.navigate(animalType: AnimalType.promises)
                                }
                                    .padding(.trailing, 5)
                                    .padding(.top)
                                CardView(imagePath: "castrado", title: "Castrados", farmData: farmData){
                                    self.navigate(animalType: AnimalType.gelding)
                                }
                                    .padding(.leading, 5)
                                    .padding(.top)

                            }
                            HStack{
                                CardView(imagePath: "receptoras", title: "Receptoras", farmData: farmData){
                                    self.navigate(animalType: AnimalType.receivers)
                                }
                                    .padding(.trailing, 5)
                                    .padding(.top)
                            }


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
