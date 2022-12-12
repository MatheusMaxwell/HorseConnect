//
//  ImageUtil.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/12/22.
//

import UIKit
import Foundation

struct ImageUtil {
    
    public static func saveImageInDocumentDirectory(image: UIImage, fileName: String){
        if loadImageFromDocumentDirectory(fileName: fileName) == nil {
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
            let fileURL = documentsUrl.appendingPathComponent(fileName)
            if let imageData = image.pngData() {
                try? imageData.write(to: fileURL, options: .atomic)
            }
        }
    }
    
    public static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
    
    public static func removeAllImages() {
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }
    
}
