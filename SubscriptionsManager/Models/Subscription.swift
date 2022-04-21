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
    
    var color: UIColor?
    var logo: String?
    
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        lhs.id == rhs.id
    }
}
