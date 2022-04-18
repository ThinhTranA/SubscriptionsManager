//
//  CurrencyRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import Foundation
import Eureka

//MARK: Row

open class _MCategoryRow<Cell: CellType>: OptionsRow<Cell>, PresenterRowType where Cell: BaseCell, Cell.Value == String {
    
    public typealias PresenterRow = CategoryPickerViewController
    
    /// Defines how the view controller will be presented, pushed, etc.
    public var presentationMode: PresentationMode<PresenterRow>?
    
    /// Will be called before the presentation occurs.
    public var onPresentCallback: ((FormViewController, PresenterRow) -> Void)?

    
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .presentModally(
            controllerProvider: ControllerProvider.callback {
                return CategoryPickerViewController()
            },
            onDismiss: { vc in
                vc.dismiss(animated: true)
            })
    }

    
    /// Extends `didSelect` method
    /// Selecting the Image Row cell will open a popup to choose where to source the photo from,
    /// based on the `sourceTypes` configured and the available sources.
    open override func customDidSelect() {
        guard !isDisabled else {
            super.customDidSelect()
            return
        }
        deselect()
        
        guard let presentationMode = presentationMode else { return }
        if let controller = presentationMode.makeController() {
            controller.row = self
            controller.title = selectorTitle ?? controller.title
            onPresentCallback?(cell.formViewController()!, controller)
            presentationMode.present(controller, row: self, presentingController: self.cell.formViewController()!)
        } else {
            presentationMode.present(nil, row: self, presentingController: self.cell.formViewController()!)
        }
    }
    
    /**
     Prepares the pushed row setting its title and completion callback.
     */
    open override func prepare(for segue: UIStoryboardSegue) {
        super.prepare(for: segue)
        guard let rowVC = segue.destination as? CategoryPickerViewController else { return }
        rowVC.title = selectorTitle ?? rowVC.title
        rowVC.onDismissCallback = presentationMode?.onDismissCallback ?? rowVC.onDismissCallback
        onPresentCallback?(cell.formViewController()!, rowVC)
        rowVC.row = self
    }
    
    open override func customUpdateCell() {
        super.customUpdateCell()
        
        cell.accessoryType = .none
        cell.editingAccessoryView = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = M.Colors.white
        cell.textLabel?.font = M.Fonts.rowTitle
        
        if(value == nil){
            cell.detailTextLabel?.textColor = M.Colors.greyWhite
        }else {
            cell.detailTextLabel?.textColor = M.Colors.white
        }
    }
    

}

/// A selector row where the user can pick an image
public final class MCategoryRow : _MCategoryRow<PushSelectorCell<String>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

