//
//  AnimalsRegisterView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import SwiftUI

struct AnimalsRegisterView: View {
    
    @StateObject private var model = AnimalsRegisterViewModel()
    @State var showSheetTypes = false
    @Environment(\.dismiss) var dismiss
    
    private let allTypesPossible = [
        AnimalType.stallion.rawValue,
        AnimalType.donor.rawValue,
        AnimalType.foal.rawValue,
        AnimalType.competitors.rawValue,
        AnimalType.promises.rawValue,
        AnimalType.gelding.rawValue,
        AnimalType.receivers.rawValue,
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Form{
                    VStack(alignment: .center){
                        image
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12, corners: [.allCorners])
                        .padding(.top, 20)
                        Button("Adicionar imagem", action: {
                            model.bindings.showGalleryToSelectImage.wrappedValue.toggle()
                        })
                        .padding(.leading)
                        .padding(.top)
                    }
                    .sheet(isPresented: model.bindings.showGalleryToSelectImage){
                        ImagePicker(selectedImage: model.bindings.imageSelected)
                    }
                    
                    TextField("Nome", text: model.bindings.animalName)
                    DatePicker(selection: model.bindings.birthDateAnimal, displayedComponents: .date, label: {
                        Text("Data Nascimento")
                    })
                    TextField("Pelagem", text: model.bindings.coatAnimal)
                    Picker("Sexo", selection: model.bindings.sexAnimal) {
                        Text("Macho").tag("Macho")
                        Text("Fêmea").tag("Fêmea")
                    }
                    Toggle("Vivo?", isOn: model.bindings.isLiveAnimal)
                    pickerMultiSelect
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                Spacer()
                Button(action: {
                    self.model.createAnimal() {
                        self.dismiss()
                    }
                }) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: model.state.canSubmit)
                }
                .primaryButtonStyle(isEnabled: model.state.canSubmit)
                .padding()
            }
            AppProgressView(show: model.state.loading)
        }
        
        
    }
    
    var pickerMultiSelect: some View {
        HStack{
            Text("Categorias")
            Spacer()
            Text("\((model.state.types.count != 0) ? String(model.state.types.count) : "Nenhuma") categoria\(model.state.types.count > 1 ? "s" : "")")
                .foregroundColor(Color(uiColor: UIColor.label).opacity(0.65))
            
            Image(systemName: "chevron.up.chevron.down")
                .resizable()
                .frame(width: 10, height: 11)
                .foregroundColor(Color(uiColor: UIColor.label).opacity(0.65))
        }
        .padding(.trailing,13)
        .onTapGesture {
            showSheetTypes.toggle()
        }
        .sheet(isPresented: $showSheetTypes){
            NavigationView{
                List(allTypesPossible, id: \.self){ type in
                    MultipleSelectionRow(
                        title: type.toAnimalTypeDescription(),
                        isSelected: self.model.state.types.contains(type)
                    ){
                        model.addOrRemoveItem(type: type)
                    }
           
                }
                .navigationTitle("Categorias")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showSheetTypes.toggle()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(Color(UIColor.label).opacity(0.54))
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    @ViewBuilder
    var image: some View {
        if model.bindings.imageSelected.wrappedValue.pngData() != nil {
            Image(uiImage: model.bindings.imageSelected.wrappedValue)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
        }
        else{
            AsyncImage(
                url: URL(string: model.state.animalImageUrl),
                content: { image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fit)

                },
                placeholder: {
                    VStack{
                        
                    }
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12, corners: [.allCorners])
                    .padding(.top, 20)
                    .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.2)
                }
            )
        }
    }

}

struct AnimalsRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsRegisterView()
    }
}
