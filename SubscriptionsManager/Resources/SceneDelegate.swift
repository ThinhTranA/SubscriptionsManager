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
        
        window.rootViewController = HomeViewController()
       // window.rootViewController = AddUpdateSubViewController()
        //window.rootViewController = AddExpenseViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
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

