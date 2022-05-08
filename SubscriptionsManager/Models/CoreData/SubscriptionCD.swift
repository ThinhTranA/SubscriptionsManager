//
//  SubscriptionCD.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 8/5/2022.
//

import Foundation
import CoreData
import UIKit

public class SubscriptionCD: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var category: String
    @NSManaged public var colorHex: String?
    @NSManaged public var logo: String?
    @NSManaged public var name: String
    @NSManaged public var nextBill: Date
    @NSManaged public var price: NSDecimalNumber
    @NSManaged public var subDescription: String
    
    @NSManaged public var billingCycleQuantity: Int
    @NSManaged public var billingCycleUnit: Int
    
    @NSManaged public var remindTime: String
    @NSManaged public var remindDay: String
    @NSManaged public var remindBefore: String
    
    @NSManaged public var currencyCode: String
    
    public override var description: String {
          return "SubscriptionCD"
      }
    
}

extension SubscriptionCD {
    var billingCycle: BillingCycle {
        guard let unit = BillingCycleUnit(rawValue: billingCycleUnit) else { return BillingCycle(quantity: billingCycleQuantity, unit: .week) }
        
        return BillingCycle(quantity: billingCycleQuantity, unit: unit)
    }
    
    var remind: Remind {
        return Remind(time: remindTime, day: remindDay, before: remindBefore)
    }
    
    var currency: Currency? {
        return CurrencyService.shared.getCurrency(withCode: currencyCode )
    }
    
    var color: UIColor? {
        if let colorHex = colorHex {
            return UIColor.init(hexaString: colorHex)
        }
        return nil
    }

    var costString: String {
        "\(price) \(currency?.symbol ?? "$")"
    }
    var logoDefault: String {
        logo ?? "photo"
    }

    var isOverdue: Bool {
        return (nextBill.days(sinceDate: Date.now) ?? 0) < 0
    }

    var dueDateString: String{
        let dueInDays = nextBill.days(sinceDate: Date.now) ?? 0

        if(dueInDays < 0){
            return "Overdue \(abs(dueInDays)) day(s) ago"
        }
        else if dueInDays == 0 {
            return "Due today"
        } else if dueInDays == 1{
          return "Due tomorrow"
        } else if dueInDays < 7 {
            return "Due in \(dueInDays) days"
        } else if dueInDays > 28 {
            return "Due in \(dueInDays/28) month(s)"
        } else {
            return "Due in \(dueInDays/7) week(s)"
        }
    }
}

extension SubscriptionCD {
    static func getAllSubscriptionData() -> NSFetchRequest<SubscriptionCD>{
        let request: NSFetchRequest<SubscriptionCD> = SubscriptionCD.fetchRequest() as! NSFetchRequest<SubscriptionCD>
        return request
    }
}
