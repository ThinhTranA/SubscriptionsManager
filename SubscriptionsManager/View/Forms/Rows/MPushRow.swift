//
//  MPushRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import Foundation
import Eureka

public final class MPushRow<T: Equatable> : _PushRow<PushSelectorCell<T>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
    
    override public func updateCell() {
        super.updateCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = M.Colors.white
        cell.textLabel?.font = M.Fonts.rowTitle
        cell.detailTextLabel?.textColor = M.Colors.white
        cell.selectionStyle = .none
        cell.accessoryType = .none
    }

}


