//
//  URLCacheExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/12/22.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
