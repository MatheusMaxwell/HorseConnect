//
//  ButtonExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

extension Button {
    
    func primaryButtonStyle(isEnabled: Bool, color: Color = ColorUtil.getPrimaryColor(farmData: SingletonUtil.shared.farmData)) -> some View {
        self
            .buttonStyle(.bordered)
            .background(RoundedRectangle(cornerRadius: 4)
                .foregroundColor(isEnabled ? color : Color.gray.opacity(0)))
            .disabled(isEnabled == false)
    }
    
}
