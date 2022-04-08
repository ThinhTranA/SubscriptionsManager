//
//  MDateRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 8/4/2022.
//

import Foundation
import Eureka

public final class MDateRow: _DateRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
    
    override public func updateCell() {
        super.updateCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .init(white: 1, alpha: 0.9)
        cell.detailTextLabel?.textColor = .init(white: 1, alpha: 0.9)
        
//
//        cell.titleLabel?.textColor = .init(white: 1, alpha: 0.9)
//        cell.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
//        cell.textField.textColor = .white
    }
}
