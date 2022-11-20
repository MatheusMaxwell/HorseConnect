//
//  SearchView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    var onChange: (String) -> Void
    
    init(searchText: String = "", onChange: @escaping (String) -> Void) {
        self.searchText = searchText
        self.onChange = onChange
    }
    
    var body: some View {
        TextField("Procurar",text: $searchText)
            .padding()
            .overlay{
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1.0)
                    .shadow(radius: 100)
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(UIColor.label).opacity(0.54))
                        .padding(.trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .onChange(of: searchText){
                onChange($0)
            }
            .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(){_ in
            
        }
    }
}
