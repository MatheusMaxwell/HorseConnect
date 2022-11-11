//
//  SingletonUtil.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//


class SingletonUtil{
    static let shared = SingletonUtil()
    
    private init(){
        
    }
    
    var userUid : String = ""
    var farmData: FarmData? = nil

}
