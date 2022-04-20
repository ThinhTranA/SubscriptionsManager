//
//  SubscriptionService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 21/4/2022.
//

import Foundation

class SubscriptionService {
    static let shared = SubscriptionService()
    
    private var subscriptionList = [Subscription]()
    
    func getAllSubscriptions() -> [Subscription]{
        subscriptionList
    }
    
    func getSubscription(by id: String) -> Subscription?{
        subscriptionList.first{ sub in
            sub.id == id
        }
    }
    
    func saveSubscription(_ subscription: Subscription){
        //TODO: check if exist to update instead of add
        
        //insert ?
        subscriptionList.append(subscription)
    }
    
    func deleteSubscription(_ subscription: Subscription){
         if let index = subscriptionList.firstIndex(of: subscription){
            subscriptionList.remove(at: index)
        }
    }
}
