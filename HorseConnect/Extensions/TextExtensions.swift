//
//  TextExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

extension Text {
    
    func textPrimaryButtonStyle(isEnabled: Bool) -> some View {
        self
            .bold()
            .foregroundColor(isEnabled ? Color.white : Color.gray)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(8)
    }
    
    func textPrimaryButtonStyle(isEnabled: Bool, padding: Double) -> some View {
        self
            .bold()
            .foregroundColor(isEnabled ? Color.white : Color.gray)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(padding)
    }
    
}
