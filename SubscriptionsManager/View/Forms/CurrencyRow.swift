//
//  CurrencyRow.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import Foundation
import Eureka

//MARK: Row

open class _CurrencyRow<Cell: CellType>: OptionsRow<Cell>, PresenterRowType where Cell: BaseCell, Cell.Value == String {
    
    //public typealias PresenterRow = CurrencyPickerController
    
    /// Defines how the view controller will be presented, pushed, etc.
    public var presentationMode: PresentationMode<CurrencyPickerController>?
    
    /// Will be called before the presentation occurs.
    public var onPresentCallback: ((FormViewController, CurrencyPickerController) -> Void)?

    
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .presentModally(controllerProvider: ControllerProvider.callback { return CurrencyPickerController() }, onDismiss: { [weak self] vc in
            self?.select()
            vc.dismiss(animated: true)
            })
        self.displayValueFor = nil
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
        
        super.customDidSelect()
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
        guard let rowVC = segue.destination as? CurrencyPickerController else { return }
        rowVC.title = selectorTitle ?? rowVC.title
        rowVC.onDismissCallback = presentationMode?.onDismissCallback ?? rowVC.onDismissCallback
        onPresentCallback?(cell.formViewController()!, rowVC)
        rowVC.row = self
    }
    
    open override func customUpdateCell() {
        super.customUpdateCell()
        
        cell.accessoryType = .none
        cell.editingAccessoryView = .none
        
//        if let image = self.value {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//            imageView.contentMode = .scaleAspectFill
//            imageView.image = image
//            imageView.clipsToBounds = true
//
//            cell.accessoryView = imageView
//            cell.editingAccessoryView = imageView
//        } else {
//            cell.accessoryView = nil
//            cell.editingAccessoryView = nil
//        }
    }
    

}

/// A selector row where the user can pick an image
public final class CurrencyRow : _CurrencyRow<PushSelectorCell<String>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

