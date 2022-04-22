//
//  TotalSubHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 22/4/2022.
//

import Foundation
import UIKit

class TotalSubHeader: UITableViewHeaderFooterView {
    static let identifier = "TotalSubHeader"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
