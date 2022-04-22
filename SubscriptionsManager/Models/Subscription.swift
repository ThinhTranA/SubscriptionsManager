//
//  Subscription.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import Foundation
import UIKit

struct Subscription: Equatable{
    let id: String = UUID().uuidString
    var name: String
    var description: String
    var category: String
    var nextBill: Date
    var billingCycle: (Int, String)
    var remind: (String, String, String)
    var currency: Currency?
    var price: Decimal
    var nextBillDate: Date?
    
    var color: UIColor?
    var logo: String?
    
    var billingCycleString: String {
        "\(billingCycle.0) \(billingCycle.1)"
    }
    var costString: String {
        "\(price) \(currency?.symbol ?? "$")"
    }
    var logoDefault: String {
        logo ?? "photo"
    }
    
    
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        lhs.id == rhs.id
    }
}
