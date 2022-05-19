//
//  NotificationsModel.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 20/5/2022.
//

import Foundation

struct NotificationModel {
    let id: String
    let title: String
    let body: String
    let recurringDate: DateComponents
    let isRepeat: Bool
}

    //let uuidString = UUID().uuidString

//                // Configure the recurring date.
//                var dateComponents = DateComponents()
//                dateComponents.calendar = Calendar.current
//
//                dateComponents.weekday = 6  //3  // Tuesday
//                dateComponents.hour = 7
//                dateComponents.minute = 22
//                dateComponents.second = 01
