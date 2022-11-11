//
//  OverlatModifier.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI



struct Overlay<T: View>: ViewModifier {
    
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}
