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
            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
            if let imageData = image.pngData() {
                do {
                    try imageData.write(to: fileURL, options: .atomic)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    public static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        
        let fileURL = getDocumentsDiretory().appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }
    
    public static func removeAllImages() {
        let fileManager = FileManager.default
        let myDocuments = getDocumentsDiretory()
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }
    
    public static func getDocumentsDiretory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
