//
//  AddUpdateSubViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 7/4/2022.
//


import UIKit
import Eureka

class AddUpdateSubViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemPink
        
        form +++ Section() { section in
            section.header = {
                var header = HeaderFooterView<UIView>(.callback({
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                    view.backgroundColor = .green
                    return view
                }))
                header.height = { 100 }
                return header
            }()
        }
        <<< MTextRow(){
            $0.title = "Name"
            $0.placeholder = "Add a name"
            $0.value = "Netflix"
        }
        <<< MTextRow(){
            $0.title = "Description"
            $0.placeholder = "Add a description"
        }
        <<< MTextRow(){
            $0.title = "Category"
            $0.placeholder = "Choose a Category" // TODO: Picker
        }
        <<< MDateRow(){
            $0.title = "Next Bill"
            if $0.value == nil {
                $0.value = Date()
            }
        }
        <<< MTextRow(){
            $0.title = "Billing Cycle"
            $0.placeholder = "Choose" // TODO Add a picker
        }
        <<< MTextRow(){
            $0.title = "Remind"
            $0.placeholder = "Choose" // TODO: add picker
        }
        <<< MTextRow(){
            $0.title = "Currency"
            $0.placeholder = "Choose" // TODO: add picker
        }
        
        //https://github.com/xmartlabs/Eureka/blob/master/README.md#row-catalog
    }
}
