//
//  CachedImageView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 21/11/22.
//

import SwiftUI
import CachedAsyncImage

struct CachedImageView: View {
    
    
    var imageUrl: String
    var width: Double
    var height: Double
    var imageSelected: UIImage? = nil
    
    var body: some View {
        if imageSelected != nil {
            Image(uiImage: imageSelected!)
                .resizable()
                .frame(width: width, height: height)
                .aspectRatio(contentMode: .fit)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(12, corners: [.allCorners])
        }
        else if imageUrl.isEmpty == false{
            if let imageLocal = ImageUtil.loadImageFromDocumentDirectory(fileName: imageUrl.fileName()){
                Image(uiImage: imageLocal)
                    .resizable()
                    .frame(width: width, height: height)
                    .aspectRatio(contentMode: .fit)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(12, corners: [.allCorners])
            }
            else{
                CachedAsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                            .cornerRadius(12, corners: [.allCorners])
                            .onAppear{
                                ImageUtil.saveImageInDocumentDirectory(image: image.asUIImage(), fileName: imageUrl.fileName())
                            }
                    },
                    placeholder: {
                        Rectangle()
                            .foregroundColor(Color.gray.opacity(0.4))
                            .cornerRadius(6, corners: [.allCorners])
                            .frame(width: width, height: height)
                    }
                )
                .frame(width: width, height: height)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12, corners: [.allCorners])
                .padding(.top, 20)
            }
            
        }
        else{
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.4))
                .cornerRadius(6, corners: [.allCorners])
                .frame(width: width, height: height)
        }
        
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(imageUrl: "", width: 50.0, height: 50.0)
    }
}
