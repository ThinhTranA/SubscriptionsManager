//
//  Subscription.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import Foundation
import UIKit

struct Subscription: Codable, Equatable {
    let id: String = UUID().uuidString
    var name: String
    var description: String
    var category: String
    var nextBill: Date
    var billingCycle: BillingCycle
    var remind: Remind
    var currency: Currency?
    var price: Decimal
    var logo: String?
    var colorHex: String?
    

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


    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        lhs.id == rhs.id
    }
}
