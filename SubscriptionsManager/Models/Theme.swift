//
//  Theme.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 16/5/2022.
//

import Foundation
import UIKit

enum Theme: Int {
    case System
    case Dark
    case Light
    
    var description: String {
        switch(self){
        case .System: return "System default theme"
        case .Dark: return "Dark theme"
        case .Light: return "Light theme"
        }
    }
    
    var icon: UIImage {
        switch(self){
        case .System: return UIImage(systemName: "gear")!
        case .Dark: return UIImage(systemName: "lightbulb.slash")!
        case .Light: return UIImage(systemName: "lightbulb")!
        }
    }
    
    static var allValues: [Theme]{
        return [.System,.Dark,.Light]
    }
    
}
