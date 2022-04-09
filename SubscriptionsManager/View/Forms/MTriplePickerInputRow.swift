//
//  MTriplePickerInputRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 9/4/2022.
//

import Foundation
import Eureka

public final class MTriplePickerInputRow<A, B, C>: _TriplePickerInputRow<A, B, C>, RowType where A: Equatable, B: Equatable, C: Equatable {
    
    var selectedC: String?
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = M.Colors.white
        cell.textLabel?.font = M.Fonts.rowTitle
        self.displayValueFor = { [weak self] tuple in
            guard let tuple = tuple else {
                return self?.noValueDisplayText
            }
            return String(describing: tuple.a) + " " + String(describing: tuple.b) + " " + String(describing: tuple.c)
        }
        cell.detailTextLabel?.textColor = M.Colors.white
    }
    
    override public func updateCell() {
        super.updateCell()
        cell.textLabel?.textColor = M.Colors.white
        cell.textLabel?.font = M.Fonts.rowTitle
        
    }
    
  

}
