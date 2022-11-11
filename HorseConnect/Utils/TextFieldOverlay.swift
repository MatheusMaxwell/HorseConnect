//
//  TextFieldOverlay.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct TextFieldOverlay {

    func shape() -> some View{
        return RoundedRectangle(cornerRadius: 4)
            .stroke(Color.gray, lineWidth: 1.0)
    }
    
}

