//
//  ButtonExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

extension Button {
    
    func primaryButtonStyle(isEnabled: Bool) -> some View {
        self
            .buttonStyle(.bordered)
            .background(RoundedRectangle(cornerRadius: 4)
                .foregroundColor(isEnabled ? .primaryColor : Color.gray.opacity(0)))
            .disabled(isEnabled == false)
    }
    
}
