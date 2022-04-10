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
        <<< MTriplePickerInputRow<String, Int, String>() {
            $0.firstOptions = { return ["Every"]}
            $0.secondOptions = { a in
                //print("a: \(a)")
                return [1, 2, 3]}
            $0.thirdOptions = { b, c in
//                print("b:\(b)")
//                print("c: \(c)")
                return ["week(s)","month(s)","year"]}
            $0.title = "Billing Cycle"
            $0.value = .init(a: "Every", b: 1, c: "week(s)")
        }.onChange{
            if($0.selectedC == $0.value?.c){
                return
            }
            $0.selectedC = $0.value?.c
            $0.value = .init(a: $0.value?.a ?? "Every", b: 1, c: $0.value?.c ?? "week(s)")
            switch $0.value?.c {
            case "week(s)":
                $0.secondOptions = { _ in
                return [1,2,3,4,5,6]
            }
            case "month(s)":
                $0.secondOptions = { _ in
                return [1,2,3,4,5,6,7,8,9,10,11,12]
            }
            case "year":
                $0.secondOptions = { _ in
                return [1]
            }
            default:
                break
            }
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
    
    override func inputAccessoryView(for row: BaseRow) -> UIView? {
        
        if row is MTriplePickerInputRow<String, Int, String>
            || row is MDateRow {
            
            let view = FormPickerInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.width, height: 42))
            view.delegate = self
            view.configure(withTitle: row.title ?? "")
            
            return view
        }
        return super.inputAccessoryView(for: row)
    }
    
    
    override func valueHasBeenChanged(for: BaseRow, oldValue: Any?, newValue: Any?) {
        print("old value\(oldValue)")
        print("new value \(newValue)")
    }
}

extension AddUpdateSubViewController: FormPickerInputAccessoryViewDelegate {
    func didTapDone() {
        tableView.endEditing(false)
    }
    func didTapCancel() {
        tableView.endEditing(false)
    }
}
