//
//  Currency.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import Foundation

public struct Currency: Codable, Equatable {
    let code: String
    let name: String
    let locale: String
    var symbol: String?
    var display: Int
    
    var countryCode: String {
        let components = locale.components(separatedBy: "_")
        return components.last!
    }
}
