//
//  NotificationsService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 20/5/2022.
//

import Foundation
import UserNotifications
import UIKit

class NotificationsService {
    static let shared = NotificationsService()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization(){
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (permissionGranted, error) in
            if(!permissionGranted) {
                print("permission denied")
            } else {
                print("permission granted")
            }
            
        })
    }
    
    func scheduleNotification(targetVC: UIViewController, with notification: NotificationModel){
        notificationCenter.getNotificationSettings { settings in
            
            DispatchQueue.main.async {
                
                if(settings.authorizationStatus == .authorized){
                    let content = UNMutableNotificationContent()
                    content.title = notification.title
                    content.body = notification.body
                    
                    // Create the trigger as a repeating event.
                    let trigger = UNCalendarNotificationTrigger(
                        dateMatching: notification.recurringDate, repeats: notification.isRepeat)
                    // Create the request
                    let request = UNNotificationRequest(identifier: notification.id,
                                                        content: content, trigger: trigger)
                    // Schedule the request with the system.
                    let notificationCenter = UNUserNotificationCenter.current()
                    notificationCenter.add(request) { (error) in
                        if error != nil {
                            // Handle any errors.
                            print("error sending notification")
                        }
                    }
                }
                else {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "settings", style: .default) { _ in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else {return}
                        
                        if(UIApplication.shared.canOpenURL(settingsURL)){
                            UIApplication.shared.open(settingsURL) { _ in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default))
                    targetVC.present(ac, animated: true)
                }
            }
        }
    }
    
    func cancelScheduledNotification(withIdentifier id: String){
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func cancelScheduledNotifications(withIdentifiers ids: [String]){
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
