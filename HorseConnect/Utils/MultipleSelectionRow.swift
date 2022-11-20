//
//  MultipleSelectionRow.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 20/11/22.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(Color(uiColor: UIColor.label))
    }
}
