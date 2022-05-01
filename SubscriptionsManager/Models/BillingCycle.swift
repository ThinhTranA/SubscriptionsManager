//
//  BillingCycle.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 2/5/2022.
//

import Foundation

struct BillingCycle {
    var quantity: Int
    var unit: BillingCycleUnit
    
    var description: String {
        "\(quantity) \(unit)\(quantity>1 ? "s" : "")"
    }
}

enum BillingCycleUnit {
    case week
    case month
    case year
}
