//
//  AnimalDetailView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 21/11/22.
//

import SwiftUI

struct AnimalDetailView: View {
    
    @StateObject private var model = AnimalDetailViewModel()
    @State var animal: Animal
    @State var navigateToAnimalRegisterView = false
    @State var navigateToAnimalGenealogyView = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
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
                        SingletonUtil.shared.animal = animal
                        navigateToAnimalRegisterView.toggle()
                    }
                Text(animal.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                CachedImageView(imageUrl: animal.imageUrl ?? "", width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25)
                    .frame(maxWidth: .infinity, alignment: .center)
                Group{
                    TitleDescriptionView(title: "Nascimento:", description: animal.birthDate.getDateFromIsoDateString())
                    TitleDescriptionView(title: "Idade:", description: animal.birthDate.getYearsDifference())
                    TitleDescriptionView(title: "Meses:", description: animal.birthDate.getMonths())
                    TitleDescriptionView(title: "Sexo:", description: animal.sex)
                    TitleDescriptionView(title: "Pelagem:", description: animal.coat)
                    TitleDescriptionView(title: "Vivo:", description: animal.isLive ? "Sim" : "Não")
                }
                Spacer()
                Button(action: {
                    navigateToAnimalGenealogyView.toggle()
                }) {
                    Text("GENEALOGIA")
                        .textPrimaryButtonStyle(isEnabled: true)
                }
                .primaryButtonStyle(isEnabled: true)
                Group{
                    NavigationLink(
                        destination: AnimalGenealogyView(animal: animal),
                        isActive: $navigateToAnimalGenealogyView,
                        label: {}
                    )
                    NavigationLink(
                        destination: AnimalsRegisterView(),
                        isActive: $navigateToAnimalRegisterView,
                        label: {}
                    )
                }
            }
            .alert(isPresented: model.bindings.showAlertDelete){
                Alert(
                    title: Text("Deletar"),
                    message: Text("Deseja realmente deletar?"),
                    primaryButton: .default(Text("Sim")){
                        if let animalId = animal.id {
                            model.deleteAnimalById(animalId: animalId){
                                self.dismiss()
                            }
                        }
                    },
                    secondaryButton: .destructive(Text("Não"))
                )
            }
            .onAppear{
                if let anim = SingletonUtil.shared.animal {
                    self.animal = anim
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            AppProgressView(show: model.state.loading)
        }
        
    }
    
    func titleDescription(title: String, description: String) -> some View{
        return HStack{
            Text(title)
            Text(description)
                .foregroundColor(.black.opacity(0.6))
        }
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(animal: Animal(name: "Otelo da Santa Vitória", birthDate: "2019-12-31T13:25:00Z", coat: "Castanho Pampa", sex: "Macho", isLive: true, userId: ""))
    }
}
