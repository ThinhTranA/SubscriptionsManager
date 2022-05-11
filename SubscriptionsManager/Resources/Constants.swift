//
//  Constants.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 9/4/2022.
//

import Foundation
import UIKit

struct M {
    struct Colors {
        static let white = UIColor.init(white: 1, alpha: 0.9)
        static let greyWhite = UIColor.init(white: 1, alpha: 0.6)
        
        //https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=4c9e7e
        static let primaryColor = UIColor(hexaString: "4c9e7e")
        static let primaryLight = UIColor(hexaString: "7dcfad")
        static let primaryDark = UIColor(hexaString: "166f52")
    }
    
    struct Fonts {
        static let modalTitle = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let rowTitle = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
