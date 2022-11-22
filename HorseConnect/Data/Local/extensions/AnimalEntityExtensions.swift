//
//  AnimalEntityExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

extension AnimalEntity {
    
    func toAnimal() -> Animal {
        return Animal(id: self.id, name: self.name ?? "", imageId: self.imageId, imageUrl: self.imageUrl, birthDate: self.birthDate ?? "", coat: self.coat ?? "", sex: self.sex ?? "", isLive: self.isLive, types: self.types?.components(separatedBy: ","), userId: self.userId ?? "")
    }

}

extension [AnimalEntity]{
    
    func toAnimals() -> [Animal] {
        return self.map{
            $0.toAnimal()
        }
    }
    
}
