//
//  AnimalsRegisterViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import Combine
import Foundation
import SwiftUI
import FirebaseStorage

class AnimalsRegisterViewModel: ObservableObject {
    
    @Published private(set) var state = AnimalsRegisterViewState()
    private let storage = Storage.storage()
    private let repository = Repository()
    
    var bindings: (
        animalName: Binding<String>,
        animalImageUrl: Binding<String>,
        birthDateAnimal: Binding<Date>,
        coatAnimal: Binding<String>,
        sexAnimal: Binding<String>,
        isLiveAnimal: Binding<Bool>,
        types: Binding<[String]>,
        loading: Binding<Bool>,
        imageSelected: Binding<UIImage?>,
        showGalleryToSelectImage: Binding<Bool>
    ) {
        (
            animalName: Binding(to: \.state.animalName, on: self),
            animalImageUrl: Binding(to: \.state.animalImageUrl, on: self),
            birthDateAnimal: Binding(to: \.state.birthDateAnimal, on: self),
            coatAnimal: Binding(to: \.state.coatAnimal, on: self),
            sexAnimal: Binding(to: \.state.sexAnimal, on: self),
            isLiveAnimal: Binding(to: \.state.isLiveAnimal, on: self),
            types: Binding(to: \.state.types, on: self),
            loading: Binding(to: \.state.loading, on: self),
            imageSelected: Binding(to: \.state.imageSelected, on: self),
            showGalleryToSelectImage: Binding(to: \.state.showGalleryToSelectImage, on: self)
        )
    }
    
    func createAnimal(complete: @escaping () -> Void){
        self.state.loading = true
        self.uploadImage { imageId, url in
            let userId = SingletonUtil.shared.userUid
            let animal = Animal(name: self.state.animalName, imageId: imageId, imageUrl: url, birthDate: self.state.birthDateAnimal.ISO8601Format(), coat: self.state.coatAnimal, sex: self.state.sexAnimal, isLive: self.state.isLiveAnimal, types: self.state.types, userId: userId)
            DispatchQueue.main.async {
                self.repository.addAnimal(animal: animal){
                    self.state.loading = false
                    complete()
                }
            }
        }
    }
    
    func updateAnimal(complete: @escaping () -> Void){
        self.state.loading = true
        self.updateImage(imageId: SingletonUtil.shared.animal?.imageId ?? "") { imageId, url in
            let userId = SingletonUtil.shared.userUid
            let animal = Animal(id: SingletonUtil.shared.animal?.id, name: self.state.animalName, imageId: imageId, imageUrl: url, birthDate: self.state.birthDateAnimal.ISO8601Format(), coat: self.state.coatAnimal, sex: self.state.sexAnimal, isLive: self.state.isLiveAnimal, types: self.state.types, userId: userId)
            DispatchQueue.main.async {
                self.repository.updateAnimal(animal: animal){
                    self.state.loading = false
                    SingletonUtil.shared.animal = animal
                    complete()
                }
            }
        }
    }
    
    func addOrRemoveItem(type: String){
        if self.state.types.contains(type) {
            self.state.types.removeAll(where: { $0 == type })
        } else {
            self.state.types.append(type)
        }
    }
    
    func updateImage(imageId: String, complete: @escaping (_ imageId: String, _ url: String ) -> Void){
        var imageIdCopy = imageId
        if(imageIdCopy.isEmpty){
            imageIdCopy = UUID().uuidString
        }
        DispatchQueue.main.async {
            let childRef = self.storage.reference().child("animals/" + imageIdCopy + ".png")
            if let data = self.state.imageSelected?.jpegData(compressionQuality: 0.3) {
                _ = childRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        complete("", "")
                        return
                    }
                    _ = metadata.size
                    childRef.downloadURL { (url, error) in
                        guard url != nil else {
                            complete("", "")
                            return
                        }
                        
                        complete(imageIdCopy, url?.description ?? "")
                    }
                }
            }
            else{
                complete("", "")
            }
            
        }
    }
    
    func uploadImage(complete: @escaping (_ imageId: String, _ url: String ) -> Void){
        let imageId = UUID().uuidString
        DispatchQueue.main.async {
            let childRef = self.storage.reference().child("animals/" + imageId + ".png")
            if let data = self.state.imageSelected?.jpegData(compressionQuality: 0.3)  {
                _ = childRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        complete("", "")
                        return
                    }
                    _ = metadata.size
                    childRef.downloadURL { (url, error) in
                        guard url != nil else {
                            complete("", "")
                            return
                        }
                        
                        complete(imageId, url?.description ?? "")
                    }
                }
            }
            else{
                complete("", "")
            }
            
        }
    }
    
//    func setAnimal(animal: Animal?){
//        if let anim = animal {
//            self.state.animal = anim
//        }
//    }
    
    func getAnimalValues(){
        if let animal = SingletonUtil.shared.animal {
            self.state.animalName = animal.name
            self.state.animalImageUrl = animal.imageUrl ?? ""
            self.state.birthDateAnimal = ISO8601DateFormatter().date(from: animal.birthDate) ?? Date()
            self.state.coatAnimal = animal.coat
            self.state.sexAnimal = animal.sex
            self.state.isLiveAnimal = animal.isLive
            self.state.types = animal.types ?? []
        }
    }

    func openGallery(){
        self.state.showGalleryToSelectImage.toggle()
    }
}
