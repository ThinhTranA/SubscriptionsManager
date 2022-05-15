//
//  ThemeService.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 16/5/2022.
//

import Foundation
import UIKit

class ThemeService {
    static let shared = ThemeService()
    
    func setTheme(to theme: Theme){
        UserReferenceService.shared.theme = theme
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            switch(theme){
            case .System:
                sd.window?.overrideUserInterfaceStyle = .unspecified
            case .Dark:
                sd.window?.overrideUserInterfaceStyle = .dark
            case .Light:
                sd.window?.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    func setUserPreferedTheme(){
        setTheme(to: UserReferenceService.shared.theme)
    }
}
