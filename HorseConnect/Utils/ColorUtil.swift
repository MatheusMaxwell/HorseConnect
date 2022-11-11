//
//  ColorUtil.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import SwiftUI

struct ColorUtil {
    static func getPrimaryColor(farmData: FarmData?) -> Color{
        if(farmData != nil && !farmData!.primaryColor.isEmpty){
            return Color(hex: farmData!.primaryColor) ?? Color.primaryColor
        }
        return Color.primaryColor
    }
}
