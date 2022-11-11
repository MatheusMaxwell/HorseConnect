//
//  Repository.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import FirebaseFirestore
import Combine

// 2
class Repository: ObservableObject {
    private let farmDataPath: String = "farms-data"
    private let store = Firestore.firestore()
    
    func addFarmData(farmData: FarmData, userId: String, complete: @escaping () -> Void) {
        store.collection(farmDataPath).document(userId).setData(farmData.toMap()){ error in
            if let err = error {
                fatalError("Unable to add farm-data: \(err.localizedDescription).")
            }
            complete()
        }
    }
    
    func getFarmData(userId: String, complete: @escaping (FarmData?) -> Void){
        store.collection(farmDataPath).document(userId).getDocument(){ (document, error) in
            if let document = document, document.exists {
                complete(document.data()?.toFarmData() ?? nil)
            } else {
                complete(nil)
            }
        }
    }
}
