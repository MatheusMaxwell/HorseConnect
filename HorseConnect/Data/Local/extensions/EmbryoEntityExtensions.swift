//
//  EmbryoEntityExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//

extension EmbryoEntity {
    
    func toEmbryo() -> Embryo {
        return Embryo(
            id: self.id,
            female: self.female ?? "",
            femaleId: self.femaleId ?? "",
            male: self.male ?? "",
            maleId: self.maleId ?? "",
            receiver: self.receiver ?? "",
            receiverId: self.receiverId ?? "",
            date: self.date ?? "",
            userId: self.userId ?? ""
        )
    }

}

extension [EmbryoEntity]{
    
    func toEmbryos() -> [Embryo] {
        return self.map{
            $0.toEmbryo()
        }
    }
    
}
