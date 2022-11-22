//
//  AnimalDetailView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 21/11/22.
//

import SwiftUI

struct AnimalDetailView: View {
    
    @State var animal: Animal
    @State var navigateToAnimalRegisterView = false
    @State var navigateToAnimalGenealogyView = false
    
    var body: some View {
        VStack(alignment: .leading) {
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
            CachedImageView(imageUrl: animal.imageUrl ?? "", width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.3)
                .frame(maxWidth: .infinity, alignment: .center)
            titleDescription(title: "Nascimento:", description: animal.birthDate.getDateFromIsoDateString())
            titleDescription(title: "Sexo:", description: animal.sex)
            titleDescription(title: "Pelagem:", description: animal.coat)
            titleDescription(title: "Vivo:", description: animal.isLive ? "Sim" : "Não")
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
        .onAppear{
            if let anim = SingletonUtil.shared.animal {
                self.animal = anim
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
