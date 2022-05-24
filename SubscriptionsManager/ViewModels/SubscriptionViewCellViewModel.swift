//
//  SubscriptionViewCellViewModel.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 3/4/2022.
//

import Foundation

struct SubscriptionViewCellViewModel {
    let subId: ObjectIdentifier
    let name: String
    let logo: String
    let cost: String
    let dueDate: String
    let isOverDue: Bool
    let isCustom: Bool
    
    init(subscriptionObj: SubscriptionCD){
        subId = subscriptionObj.id
        name = subscriptionObj.name
        logo = subscriptionObj.logoDefault
        cost = subscriptionObj.costString
        dueDate = subscriptionObj.dueDateString
        isOverDue = subscriptionObj.isOverdue
        isCustom = subscriptionObj.isCustom
    }
}
