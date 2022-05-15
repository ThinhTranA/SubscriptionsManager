//
//  UserPreferenceService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/5/2022.
//

import Foundation


class UserReferenceService {
    static let shared = UserReferenceService()
    
    private let userDefalts = UserDefaults.standard
    private let currencyCodeKey = "currencyCodeKey"
    private let themeKey = "themeKey"
    
    var currencyCode : String {
        get {
            userDefalts.object(forKey: currencyCodeKey) as? String ?? "USD"
        }
        set {
            userDefalts.set(newValue, forKey: currencyCodeKey)
        }
    }
    
    var theme: Theme {
        get {
            let rawV = userDefalts.object(forKey: themeKey)
            return Theme(rawValue: rawV as? Int ?? Theme.System.rawValue) ?? .System
        }
        set {
            userDefalts.set(newValue.rawValue, forKey: themeKey)
        }
    }
}
