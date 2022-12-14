//
//  EmbryoRegisterView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

import SwiftUI

let PICKER_EMPTY_STATE = "Nenhum animal"

struct EmbryoRegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var model = EmbryoRegisterViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Form{
                    Picker("Cavalo", selection: model.bindings.maleSelected) {
                        Text(PICKER_EMPTY_STATE).tag(PICKER_EMPTY_STATE)
                        ForEach(model.state.animalsMale, id: \.self) { animal in
                            Text(animal.name)
                                .tag(animal.name)
                        }
                    }
                    Picker("Égua", selection: model.bindings.femaleSelected) {
                        Text(PICKER_EMPTY_STATE).tag(PICKER_EMPTY_STATE)
                        ForEach(model.state.animalsFemale, id: \.self) { animal in
                            Text(animal.name)
                                .tag(animal.name)
                        }
                    }
                    Picker("Receptora", selection: model.bindings.receiversSelected) {
                        Text(PICKER_EMPTY_STATE).tag(PICKER_EMPTY_STATE)
                        ForEach(model.state.animalsReceivers, id: \.self) { animal in
                            Text(animal.name)
                                .tag(animal.name)
                        }
                    }
                    DatePicker(selection: model.bindings.date, displayedComponents: .date, label: {
                        Text("Data")
                    })
                    Picker("Sexo", selection: model.bindings.sexSelected) {
                        Text(EmbryoSex.UNAVAILABLE).tag(EmbryoSex.UNAVAILABLE)
                        Text(EmbryoSex.MALE).tag(EmbryoSex.MALE)
                        Text(EmbryoSex.FEMALE).tag(EmbryoSex.FEMALE)
                    }
                    Picker("Situação", selection: model.bindings.statusSelected) {
                        Text(EmbryoStatus.TO_CONFIRM).tag(EmbryoStatus.TO_CONFIRM)
                        Text(EmbryoStatus.CONFIRMED).tag(EmbryoStatus.CONFIRMED)
                    }
                }
                Button(action: {
                    self.model.createEmbryo {
                        self.dismiss()
                    }
                }) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: model.state.canSubmit)
                }
                .primaryButtonStyle(isEnabled: model.state.canSubmit)
                .padding()
            }
            AppProgressView(show: self.model.state.loading)
        }
        .onAppear{
            self.model.getAnimals()
        }
    }
}

struct EmbryoRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        EmbryoRegisterView()
    }
}
