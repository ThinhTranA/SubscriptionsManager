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
    
    var currencyCode : String {
        get {
            userDefalts.object(forKey: currencyCodeKey) as? String ?? "USD"
        }
        set {
            userDefalts.set(newValue, forKey: currencyCodeKey)
        }
    }
}
