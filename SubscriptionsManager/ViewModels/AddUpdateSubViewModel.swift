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
    var isCustom = false
    var category = ""
    var colorHex = ""
    var logo = ""
    var name = ""
    var nextBill = Date().adding(.month, value: 1)
    var price: Decimal = 0.0
    var subDescription = ""
    var billingCycle: BillingCycle = BillingCycle(quantity: 1, unit: .month)
    var remind: Remind = Remind(time: Remind.timeDefaultValue, day: Remind.dayDefaultValue, before: Remind.beforeDefaultValue)
    var currencyCode = UserReferenceService.shared.currencyCode
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
            self.billingCycle = subObj.billingCycle
            self.remind = subObj.remind
            self.currencyCode = subObj.currencyCode
            self.isCustom = subObj.isCustom
        }
    }
    
    mutating func saveSubscription() {
        if let sub = subObj {
          updateSubValues(with: sub)
        } else {
            let sub = SubscriptionCD(context: mangedObjectContext)
            updateSubValues(with: sub)
        }
        do {
            try mangedObjectContext.save()
        } catch {
            print("error saving subscription")
        }
    }
    
    private mutating func updateSubValues(with sub: SubscriptionCD){
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
        sub.currencyCode = currencyCode
        sub.isCustom = isCustom
        
        subObj = sub
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
    
    func updateRemindNotification(vc: UIViewController){
        if let sub = subObj {
            let notificationId: String = sub.objectID.description
            let name = sub.name
            var body: String
            let dayBefore = sub.remind.remindOnDayBefore
            switch(dayBefore){
            case 0:  body = "\(sub.name) bill is due Today"
            case 1:  body = "\(sub.name) bill is due Tomorrow"
            default:
                body = "\(sub.name) bill is due in \(dayBefore) date is on \(sub.nextBill.getFormattedDate(format: "dd/MM/yyyy"))"
            }
            
            print(body)
            
            var recurringDate = DateComponents()
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: sub.nextBill)
            
            let recurDay = calendarDate.day ?? 0 - sub.remind.remindOnDayBefore
            if(recurDay) < 0 {
                return
            }
            recurringDate.year = calendarDate.year
            recurringDate.month = calendarDate.month
            recurringDate.day = recurDay
            // Remind on same hour time that sub was saved.
            let date = Date()
            recurringDate.hour = Calendar.current.component(.hour, from: date)
            recurringDate.minute = Calendar.current.component(.minute, from: date)
            recurringDate.second = Calendar.current.component(.second, from: date) + 10
            
            let isRepeat = true
            
            let notification = NotificationModel(
                id: notificationId,
                title: name,
                body: body,
                recurringDate: recurringDate,
                isRepeat: isRepeat
            )
            NotificationsService.shared.scheduleNotification(targetVC: vc, with: notification)
            
        }
    }
}
