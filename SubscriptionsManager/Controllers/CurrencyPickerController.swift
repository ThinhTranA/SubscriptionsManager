//
//  CurrencyPickerController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import UIKit
import Eureka

open class CurrencyPickerController: UIViewController, TypedRowControllerType, UINavigationControllerDelegate {
    
    //TypedRowControllerType
    public var row: RowOf<String>!
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    lazy var label: UILabel = UILabel()

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        label.text = row.value
    }
    
    open override func viewDidLayoutSubviews() {
        view.addSubview(label)
        label.sizeToFit()
        label.frame = CGRect(x: view.width/2, y: view.height/2, width: label.width, height: label.height)
    }
    


}
