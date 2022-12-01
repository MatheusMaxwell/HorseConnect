//
//  TimeIntervalExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//
import Foundation

extension TimeInterval {
    
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    
    func asYears() -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }

}
