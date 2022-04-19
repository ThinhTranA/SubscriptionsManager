//
//  Subscription.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import Foundation

struct Subscription{
    var name: String
    var description: String
    var category: String
    var nextBill: Date
    var billingCycle: (Int, String)
    var remind: (String, String, String)
    var currency: String
}
