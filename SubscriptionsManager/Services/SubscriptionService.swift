//
//  SubscriptionService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 21/4/2022.
//

import Foundation
import UIKit

class SubscriptionService {
    static let shared = SubscriptionService()
    
    let mangedObjectContext = (UIApplication.shared.delegate as! AppDelegate).manangedObjectContext
    
    private var subscriptionList: [SubscriptionCD] = []
    
    func getAllSubscriptions() -> [SubscriptionCD]{
        do {
           // subscriptionList = try context.fetch(SubscriptionCD.fetchRequest())
             let subscriptionFetchResult = try mangedObjectContext.fetch(SubscriptionCD.fetchRequest()) as! [SubscriptionCD]
            subscriptionList = subscriptionFetchResult
            
        }
        catch{
            
        }
        return subscriptionList
    }
    

    
    func saveSubscription(_ subscription: SubscriptionCD){
        if let row = self.subscriptionList.firstIndex(where: {$0.id == subscription.id}) {
            subscriptionList[row] = subscription
        } else {
            subscriptionList.append(subscription)
        }
        
    }
    
    func deleteSubscription(_ subscription: SubscriptionCD){
         if let index = subscriptionList.firstIndex(of: subscription){
            subscriptionList.remove(at: index)
        }
    }
    
    
    
//    func markSubscriptionAsPaid(_ subId: UUID){
//        if var sub = getSubscription(by: subId){
//
//            if sub.billingCycle.unit == .week {
//                var nextDueDatesFromNow = 1
//                nextDueDatesFromNow = sub.billingCycle.quantity * 7
//                while(sub.nextBill.days(sinceDate: Date.now) ?? 0 < 0){
//                    sub.nextBill = Calendar.current.date(byAdding: .day, value: nextDueDatesFromNow, to: sub.nextBill) ?? sub.nextBill
//                }
//            } else if sub.billingCycle.unit == .month{
//                while(sub.nextBill.days(sinceDate: Date.now) ?? 0 < 0){
//                    sub.nextBill = Calendar.current.date(byAdding: .month, value: 1, to: sub.nextBill) ?? sub.nextBill
//                }
//            } else if sub.billingCycle.unit == .year{
//                while(sub.nextBill.days(sinceDate: Date.now) ?? 0 < 0){
//                    sub.nextBill = Calendar.current.date(byAdding: .year, value: 1, to: sub.nextBill) ?? sub.nextBill
//                }
//            }
//            
//            saveSubscription(sub)
//        }
//    }
}
