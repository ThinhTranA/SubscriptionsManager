//
//  SettingsModel.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 14/5/2022.
//

import Foundation
import UIKit

struct SettingsSection {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    var menu: UIMenu?
    let handler: (() -> Void)?
}

