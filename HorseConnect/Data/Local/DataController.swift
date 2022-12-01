//
//  DataController.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    static let shared = DataController()
    let container = NSPersistentContainer(name: "HorseConnectDB")
    private let animalEntityName = "AnimalEntity"
    private let farmDataEntityName = "FarmDataEntity"
    private let genealogyEntityName = "GenealogyEntity"
    private let embryoEntityName = "EmbryoEntity"
    
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyStoreTrumpMergePolicyType)

    }
    
    
    func saveFarmData(farmData: FarmData){
        let userId = SingletonUtil.shared.userUid
        do{
            farmData.toEntity(context: container.viewContext, id: userId)
            try container.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getFarmData() -> FarmData? {
        do {
            let request: [FarmDataEntity] = try container.viewContext.fetch(NSFetchRequest<FarmDataEntity>(entityName: farmDataEntityName))
            return request.first?.toFarmData()
        } catch let error as NSError{
            print(error)
            return nil
        }
    }
    
    func getAnimals() -> [Animal]{
        do {
            
            return try container.viewContext.fetch(NSFetchRequest<AnimalEntity>(entityName: animalEntityName)).toAnimals()
        } catch let error as NSError{
            print(error)
            return []
        }
    }
   
    func saveAnimals (animals: [Animal]) {
        animals.forEach{
            $0.toEntity(context: container.viewContext)
        }
        do{
            try container.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func saveGenealogy(genealogy: Genealogy){
        do{
            genealogy.toEntity(context: container.viewContext)
            try container.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getGenealogyById(id: String) -> Genealogy?{
        do{
            let request = NSFetchRequest<GenealogyEntity>(entityName: genealogyEntityName)
            request.predicate = NSPredicate(format: "%K == %@", "id", id)
            let genealogy: [GenealogyEntity] = try container.viewContext.fetch(request)
            return genealogy.first?.toGenealogy()
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    func getEmbryos() -> [Embryo]{
        do {
            return try container.viewContext.fetch(NSFetchRequest<EmbryoEntity>(entityName: embryoEntityName)).toEmbryos()
        } catch let error as NSError{
            print(error)
            return []
        }
    }
    
    func saveEmbryos (embryos: [Embryo]) {
        embryos.forEach{
            $0.toEntity(context: container.viewContext)
        }
        do{
            try container.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func clearAllData(){
        clearAllDataFromAnimalEntity()
        clearAllDataFromFarmDataEntity()
        clearAllDataFromGenealogyEntity()
    }
    
    private func clearAllDataFromAnimalEntity(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: animalEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func clearAllDataFromFarmDataEntity(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: farmDataEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func clearAllDataFromGenealogyEntity(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: genealogyEntityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}

