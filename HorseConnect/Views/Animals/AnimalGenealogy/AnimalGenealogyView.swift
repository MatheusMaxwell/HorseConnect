//
//  AnimalGenealogyView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

import SwiftUI

struct AnimalGenealogyView: View {
    @StateObject private var model = AnimalGenealogyViewModel()
    @State var isDisableEdit = true
    var animal: Animal
    
    init(animal: Animal){
        self.animal = animal
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Text(animal.name)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    if isDisableEdit {
                        Image(systemName: "square.and.pencil")
                            .padding(.trailing)
                            .onTapGesture {
                                isDisableEdit.toggle()
                            }
                    }
                    else{
                        Button(action: {
                            isDisableEdit.toggle()
                            model.getGenealogyByAnimal(animalId: animal.id ?? "")
                        }, label: {
                            Text("Cancelar")
                        })
                        .padding(.trailing)
                    }
                }
                List{
                    HStack{
                        animalComponent(textBinding: model.bindings.father)

                        VStack{
                            animalComponent(textBinding: model.bindings.fatherGrandFather)
                            animalComponent(textBinding: model.bindings.fatherGrandMother)
                                .padding(.top, 80)
                        }
             
                        VStack{
                            animalComponent(textBinding: model.bindings.fatherGrandFatherGreatGrandFather)
                            animalComponent(textBinding: model.bindings.fatherGrandFatherGreatGrandMother)
                            animalComponent(textBinding: model.bindings.fatherGrandMotherGreatGrandFather)
                            animalComponent(textBinding: model.bindings.fatherGrandMotherGreatGrandMother)
                        }
                    }
                    HStack{
                        animalComponent(textBinding: model.bindings.mother)
                        VStack{
                            animalComponent(textBinding: model.bindings.motherGrandFather)
                            animalComponent(textBinding: model.bindings.motherGrandMother)
                                .padding(.top, 80)
                        }
                        VStack{
                            animalComponent(textBinding: model.bindings.motherGrandFatherGreatGrandFather)
                            animalComponent(textBinding: model.bindings.motherGrandFatherGreatGrandMother)
                            animalComponent(textBinding: model.bindings.motherGrandMotherGreatGrandFather)
                            animalComponent(textBinding: model.bindings.motherGrandMotherGreatGrandMother)
                        }
                    }
                    .padding(.top, 20)
                }
                .listStyle(.plain)
                
                Button(action: {
                    model.saveGenealogy(animalId: animal.id ?? "")
                    isDisableEdit = true
                }) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: isDisableEdit == false)
                }
                .primaryButtonStyle(isEnabled: isDisableEdit == false)
                .padding(.trailing)
                .padding(.leading)
                
            }
            AppProgressView(show: model.state.loading)
        }
        .onAppear{
            model.getGenealogyByAnimal(animalId: animal.id ?? "")
        }
    }
    
    @ViewBuilder
    func animalComponent(textBinding: Binding<String>) -> some View {
        TextEditor(text: textBinding)
            .font(.system(size: 14))
            .disableAutocorrection(true)
            .lineLimit(2)
            .overlay{
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.black, lineWidth: isDisableEdit ?  1.0 : 2.0)
            }
            .disabled(isDisableEdit)
            .frame(width: UIScreen.main.bounds.width*0.25, height: UIScreen.main.bounds.height*0.06)
            .padding(.bottom)
            .padding(.trailing)
            .padding(.leading)
    }
}

struct AnimalGenealogyView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalGenealogyView(animal: Animal(name: "Otelo da Santa Vitória", imageId: "", imageUrl: "", birthDate: "", coat: "", sex: "", isLive: true, types: [], userId: ""))
    }
}
