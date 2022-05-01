//
//  BillingCycle.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 2/5/2022.
//

import Foundation

struct BillingCycle: Codable {
    var quantity: Int
    var unit: BillingCycleUnit
    
    init(quantity: Int, unit: BillingCycleUnit){
        self.quantity = quantity
        self.unit = unit
    }
    
    var description: String {
        "\(quantity) \(unit)\(quantity>1 ? "s" : "")"
    }
}

enum BillingCycleUnit: Codable {
    case week
    case month
    case year
}
