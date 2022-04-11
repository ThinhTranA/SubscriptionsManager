//
//  MTextRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 8/4/2022.
//

import Foundation
import Eureka

public final class MTextRow: _TextRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
    
    override public func updateCell() {
        super.updateCell()
        cell.backgroundColor = .clear
        cell.titleLabel?.textColor = M.Colors.white
        cell.titleLabel?.font = M.Fonts.rowTitle
        cell.textField.textColor = .white
        
        cell.textField.attributedPlaceholder = NSAttributedString (
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: M.Colors.greyWhite]
        )
    }
    

}
