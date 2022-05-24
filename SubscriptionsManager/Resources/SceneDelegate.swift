//
//  SceneDelegate.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 29/3/2022.
//

import UIKit
import Eureka

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        //let vc = HomeViewController()
        let vc = ColorPickerViewController()
        window.rootViewController = vc
        
        //path of coredata sqlite db, go 1 folder up from Document
        //Library/Application Support/ {.sqlite File here}
        //let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print(urls)
        
        self.window = window
        self.window?.makeKeyAndVisible()
        ThemeService.shared.setUserPreferedTheme()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
   
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
   
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }


}

