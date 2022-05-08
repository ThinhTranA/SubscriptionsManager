//
//  AddUpdateSubViewModel.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 8/5/2022.
//

import Foundation
import UIKit

struct AddUpdateSubViewModel {
    
    let mangedObjectContext = (UIApplication.shared.delegate as! AppDelegate).manangedObjectContext
    var subObj: SubscriptionCD?
    
    var category = ""
    var colorHex = ""
    var logo = ""
    var name = ""
    var nextBill = Date()
    var price: Decimal = 0.0
    var subDescription = ""
    var billingCycle: BillingCycle = BillingCycle(quantity: 3, unit: .week)
    var remind: Remind = Remind(time: "", day: "", before: "")
    var currencyCode = ""
    var color: UIColor? {
        if(!colorHex.isEmpty) {
            return UIColor.init(hexaString: colorHex)
        }
        return nil
    }
    var currency: Currency? {
        return CurrencyService.shared.getCurrency(withCode: currencyCode)
    }
    
    init(subObj: SubscriptionCD? = nil){
        self.subObj = subObj
        if let subObj = subObj {
            self.category = subObj.category
            self.colorHex = subObj.colorHex ?? ""
            self.logo = subObj.logo ?? ""
            self.name = subObj.name
            self.nextBill = subObj.nextBill
            self.price = subObj.price.decimalValue
            self.subDescription = subObj.subDescription
            
            
            self.currencyCode = subObj.currencyCode
        }
    }
    
    func saveSubscription() {
        if subObj != nil {
            print("sub is filled, TODO")
        } else {
            let sub = SubscriptionCD(context: mangedObjectContext)
            
            sub.createdAt = Date()
            sub.updatedAt = Date()
            sub.category = category
            sub.colorHex = colorHex
            sub.logo = logo
            sub.name = name
            sub.nextBill = nextBill
            sub.price = NSDecimalNumber(decimal: price)
            sub.subDescription = subDescription
            
            sub.billingCycleQuantity = billingCycle.quantity
            sub.billingCycleUnit = billingCycle.unit.rawValue
            
            sub.remindDay = remind.day
            sub.remindTime = remind.time
            sub.remindBefore = remind.before
        }
        do {
            try mangedObjectContext.save()
        } catch {
            print("error saving subscription")
        }
    }
    
    func deleteSubscription() {
        guard let subObj = subObj else {
            return
        }
        mangedObjectContext.delete(subObj)
        do {
            try mangedObjectContext.save()
        } catch {
            print("error deleting subscription")
        }
        
    }
    
}
