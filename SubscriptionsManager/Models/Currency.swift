//
//  Currency.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import Foundation

struct Currency: Decodable {
    let code: String
    let name: String
    let locale: String
    var display: Int
    
    var countryCode: String {
        let components = locale.components(separatedBy: "_")
        return components.last!
    }
}

struct CurrencyRanking: Decodable {
    let rank: Int
    let symbol: String
    let currencyName: String
    let popularity: String
}



