//
//  Repository.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import FirebaseFirestore
import Combine

class Repository: ObservableObject {
    private let farmDataPath: String = "farms-data"
    private let animalsPath: String = "animals"
    private let genealogiesPath: String = "genealogies"
    private let embryosPath: String = "embryos"
    private let store = Firestore.firestore()
    private let dataController = DataController.shared
    private let monitor = NetworkMonitor()
    
    func addFarmData(farmData: FarmData, userId: String, complete: @escaping () -> Void) {
        store.collection(farmDataPath).document(userId).setData(farmData.toMap()){ error in
            if let err = error {
                fatalError("Unable to add farm-data: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func getFarmData(userId: String, complete: @escaping (FarmData?) -> Void){
        if(monitor.isConnected){
            store.collection(farmDataPath).document(userId).getDocument(){ (document, error) in
                if let document = document, document.exists {
                    if let farmData = document.data()?.toFarmData() {
                        self.dataController.saveFarmData(farmData: farmData)
                        complete(farmData)
                    }
                    else{
                        complete(nil)
                    }
                } else {
                    complete(nil)
                }
            }
        }
        else{
            let farmData = dataController.getFarmData()
            complete(farmData)
        }
    }
    
    func getAnimals(complete: @escaping ([Animal]?) -> Void){
        let userId = SingletonUtil.shared.userUid
        if(monitor.isConnected){
            store.collection(animalsPath).whereField("userId", isEqualTo: userId).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    complete(nil)
                } else {
                    var animals = [Animal]()
                    for document in querySnapshot!.documents {
                        animals.append(document.data().toAnimal(id: document.documentID))
                    }
                    self.dataController.saveAnimals(animals: animals)
                    complete(animals)
                }
            }
        }
        else{
            let animals = dataController.getAnimals()
            complete(animals)
        }
    }
    
    func addAnimal(animal: Animal, complete: @escaping () -> Void) {
        store.collection(animalsPath).addDocument(data: animal.toMap()){ error in
            if let err = error {
                fatalError("Unable to add animal: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func updateAnimal(animal: Animal, complete: @escaping () -> Void) {
        store.collection(animalsPath).document(animal.id ?? "").setData(animal.toMap()){ error in
            if let err = error {
                fatalError("Unable to add animal: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func createGenealogy(animalId: String, genealogy: Genealogy, complete: @escaping () -> Void) {
        store.collection(genealogiesPath).document(animalId).setData(genealogy.toMap()){ error in
            if let err = error {
                fatalError("Unable to add genealogy: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func getGenealogyByAnimal(animalId: String, complete: @escaping (Genealogy?) -> Void){
        if(monitor.isConnected){
            store.collection(genealogiesPath).document(animalId).getDocument(completion: ) { (documentSnapshot, error) in
                if let err = error {
                    fatalError("Unable to get genealogy: \(err.localizedDescription).")
                }
                if let genealogy = documentSnapshot?.data()?.toGenealogy(id: animalId) {
                    self.dataController.saveGenealogy(genealogy: genealogy)
                    complete(genealogy)
                }
                else{
                    complete(nil)
                }
            }
        }
        else{
            let genealogy = dataController.getGenealogyById(id: animalId)
            complete(genealogy)
        }
    }
    
    func addEmbryo(embryo: Embryo, complete: @escaping () -> Void) {
        store.collection(embryosPath).addDocument(data: embryo.toMap()){ error in
            if let err = error {
                fatalError("Unable to add embryo: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func getEmbryos(complete: @escaping ([Embryo]?) -> Void){
        let userId = SingletonUtil.shared.userUid
        if(monitor.isConnected){
            store.collection(embryosPath).whereField("userId", isEqualTo: userId).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    complete(nil)
                } else {
                    var embryos = [Embryo]()
                    for document in querySnapshot!.documents {
                        embryos.append(document.data().toEmbryo(id: document.documentID))
                    }
                    self.dataController.saveEmbryos(embryos: embryos)
                    complete(embryos)
                }
            }
        }
        else{
            let embryos = dataController.getEmbryos()
            complete(embryos)
        }
    }
}
