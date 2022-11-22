//
//  AnimalGenealogyViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

import Foundation
import Combine
import SwiftUI

final class AnimalGenealogyViewModel: ObservableObject{
    @Published private(set) var state: AnimalGenealogyViewState
    private let repository = Repository()
    init(
        initialState: AnimalGenealogyViewState = .init()
    ) {
        state = initialState
    }
    
    var bindings: (
            father: Binding<String>,
            fatherGrandFather: Binding<String>,
            fatherGrandFatherGreatGrandFather: Binding<String>,
            fatherGrandFatherGreatGrandMother: Binding<String>,
            fatherGrandMother: Binding<String>,
            fatherGrandMotherGreatGrandFather: Binding<String>,
            fatherGrandMotherGreatGrandMother: Binding<String>,
            mother: Binding<String>,
            motherGrandFather: Binding<String>,
            motherGrandFatherGreatGrandFather: Binding<String>,
            motherGrandFatherGreatGrandMother: Binding<String>,
            motherGrandMother: Binding<String>,
            motherGrandMotherGreatGrandFather: Binding<String>,
            motherGrandMotherGreatGrandMother: Binding<String>
        ) {
            (
                father: Binding(to: \.state.father, on: self),
                fatherGrandFather: Binding(to: \.state.fatherGrandFather, on: self),
                fatherGrandFatherGreatGrandFather: Binding(to: \.state.fatherGrandFatherGreatGrandFather, on: self),
                fatherGrandFatherGreatGrandMother: Binding(to: \.state.fatherGrandFatherGreatGrandMother, on: self),
                fatherGrandMother: Binding(to: \.state.fatherGrandMother, on: self),
                fatherGrandMotherGreatGrandFather: Binding(to: \.state.fatherGrandMotherGreatGrandFather, on: self),
                fatherGrandMotherGreatGrandMother: Binding(to: \.state.fatherGrandMotherGreatGrandMother, on: self),
                mother: Binding(to: \.state.mother, on: self),
                motherGrandFather: Binding(to: \.state.motherGrandFather, on: self),
                motherGrandFatherGreatGrandFather: Binding(to: \.state.motherGrandFatherGreatGrandFather, on: self),
                motherGrandFatherGreatGrandMother: Binding(to: \.state.motherGrandFatherGreatGrandMother, on: self),
                motherGrandMother: Binding(to: \.state.motherGrandMother, on: self),
                motherGrandMotherGreatGrandFather: Binding(to: \.state.motherGrandMotherGreatGrandFather, on: self),
                motherGrandMotherGreatGrandMother: Binding(to: \.state.motherGrandMotherGreatGrandMother, on: self)
            )
        }
    
    func saveGenealogy(animalId: String){
        self.state.loading = true
        DispatchQueue.main.async {
            let genealogy = Genealogy(id: animalId, father: self.state.father, fatherGrandFather: self.state.fatherGrandFather, fatherGrandFatherGreatGrandFather: self.state.fatherGrandFatherGreatGrandFather, fatherGrandFatherGreatGrandMother: self.state.fatherGrandFatherGreatGrandMother, fatherGrandMother: self.state.fatherGrandMother, fatherGrandMotherGreatGrandFather: self.state.fatherGrandMotherGreatGrandFather, fatherGrandMotherGreatGrandMother: self.state.fatherGrandMotherGreatGrandMother, mother: self.state.mother, motherGrandFather: self.state.motherGrandFather, motherGrandFatherGreatGrandFather: self.state.motherGrandFatherGreatGrandFather, motherGrandFatherGreatGrandMother: self.state.motherGrandFatherGreatGrandMother, motherGrandMother: self.state.motherGrandMother, motherGrandMotherGreatGrandFather: self.state.motherGrandMotherGreatGrandFather, motherGrandMotherGreatGrandMother: self.state.motherGrandMotherGreatGrandMother)
            
            self.repository.createGenealogy(animalId: animalId, genealogy: genealogy){
                self.state.loading = false
                self.getGenealogyByAnimal(animalId: animalId)
            }
        }
    }
    
    func getGenealogyByAnimal(animalId: String){
        self.state.loading = true
        DispatchQueue.main.async {
            self.repository.getGenealogyByAnimal(animalId: animalId){ genealogy in
                
                self.state.father = genealogy?.father ?? ""
                self.state.fatherGrandFather = genealogy?.fatherGrandFather ?? ""
                self.state.fatherGrandFatherGreatGrandFather = genealogy?.fatherGrandFatherGreatGrandFather ?? ""
                self.state.fatherGrandFatherGreatGrandMother = genealogy?.fatherGrandFatherGreatGrandMother ?? ""
                self.state.fatherGrandMother = genealogy?.fatherGrandMother ?? ""
                self.state.fatherGrandMotherGreatGrandFather = genealogy?.fatherGrandMotherGreatGrandFather ?? ""
                self.state.fatherGrandMotherGreatGrandMother = genealogy?.fatherGrandMotherGreatGrandMother ?? ""
                self.state.mother = genealogy?.mother ?? ""
                self.state.motherGrandFather = genealogy?.motherGrandFather ?? ""
                self.state.motherGrandFatherGreatGrandFather = genealogy?.motherGrandFatherGreatGrandFather ?? ""
                self.state.motherGrandFatherGreatGrandMother = genealogy?.motherGrandFatherGreatGrandMother ?? ""
                self.state.motherGrandMother = genealogy?.motherGrandMother ?? ""
                self.state.motherGrandMotherGreatGrandFather = genealogy?.motherGrandMotherGreatGrandFather ?? ""
                self.state.motherGrandMotherGreatGrandMother = genealogy?.motherGrandMotherGreatGrandMother ?? ""
                
                self.state.loading = false
            }
        }
    }
}
