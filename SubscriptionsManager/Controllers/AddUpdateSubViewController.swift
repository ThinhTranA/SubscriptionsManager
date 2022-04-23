//
//  AddUpdateSubViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 7/4/2022.
//


import UIKit
import Eureka

protocol AddUpdateSubDelegate: AnyObject {
    func reloadAllSubscriptions()
}

class AddUpdateSubViewController: FormViewController {
    
    var delegate: AddUpdateSubDelegate?
    
    var subscription = Subscription(
        name: "",
        description: "",
        category: "",
        nextBill: Date(),
        billingCycle: (1, "week(s)"),
        remind: ("Never","",""),
        price: 0.00
    )
    
    private let subHeader: AddUpdateSubHeader = {
        let addUpdateHeader = AddUpdateSubHeader.init(frame: CGRect(x: 0, y: 0, width: 100, height: 220))
        return addUpdateHeader
    }()
    
    private let deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete Expense", for: .normal)
        btn.setTitleColor(M.Colors.greyWhite, for: .normal)
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.tintColor = M.Colors.greyWhite
        btn.backgroundColor = .white.withAlphaComponent(0.5)
        btn.layer.cornerRadius = 16
        
      
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDeleteBtn()
        configureNavigationBar()
        configureSubscriptionForm()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        deleteBtn.sizeToFit()
        deleteBtn.frame = CGRect(x: (view.width - deleteBtn.width)/2, y: view.height-deleteBtn.height-56, width: deleteBtn.width+16, height: deleteBtn.height+12)
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
    
    private func configureNavigationBar(){
        let newBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 24))
        newBtn.setTitle("Save", for: .normal)
        newBtn.setTitleColor(subscription.color, for: .normal)
        newBtn.titleLabel?.font = .systemFont(ofSize: 14)
        newBtn.layer.cornerRadius = 14
        newBtn.clipsToBounds = false
        newBtn.backgroundColor = M.Colors.white
        newBtn.addTarget(self, action: #selector(didTapSaveBtn), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newBtn)
        let closeBtn = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(didTapCloseBtn))
        closeBtn.tintColor = M.Colors.white
        navigationItem.leftBarButtonItem = closeBtn
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:M.Colors.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureDeleteBtn(){
        view.addSubview(deleteBtn)
        deleteBtn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
    }
    
    @objc func didTapCloseBtn(){
        dismiss(animated: true)
    }
    
    @objc func didTapSaveBtn(){
        subscription.price = Decimal(string: subHeader.costTxtField.text ?? "") ?? 0.0
        SubscriptionService.shared.saveSubscription(subscription)
        dismissAndReloadData()
    }
    
    @objc func didTapDeleteBtn(){
        SubscriptionService.shared.deleteSubscription(subscription)
        dismissAndReloadData()
    }
    
    private func dismissAndReloadData(){
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
        delegate?.reloadAllSubscriptions()
    }
    
    
    private func configureSubscriptionForm(){
        tableView.backgroundColor = subscription.color
        
        form +++ Section() { section in
            section.header = {
                var header = HeaderFooterView<UIView>(.callback({ [unowned self] in
                    self.subHeader.configure(with: self.subscription)
                    return self.subHeader
                }))
                header.height = { 220 }
                return header
            }()
        }
        <<< MTextRow(){
            $0.title = "Name"
            $0.placeholder = "Add a name"
            $0.value = subscription.name
        }.onChange{[unowned self] row in self.subscription.name = row.value!}
        <<< MTextRow(){
            $0.title = "Description"
            $0.tag = "description"
            $0.placeholder = "Add a description"
            $0.value = subscription.description
        }.onChange{[unowned self] row in self.subscription.description = row.value!}
        <<< MCategoryRow(){
            $0.title = "Category"
            $0.tag = "category"
            $0.noValueDisplayText = "Choose a Cagetory"
            $0.value = subscription.category
        }.onChange{[unowned self] row in self.subscription.category = row.value!}
        <<< MDateRow(){
            $0.title = "Next Bill"
            $0.tag = "nextBill"
            $0.value = subscription.nextBill
            if $0.value == nil {
                $0.value = Date()
            }
        }.onChange{[unowned self] row in self.subscription.nextBill = row.value!}
        <<< MTriplePickerInputRow<String, Int, String>() {
            $0.firstOptions = { return ["Every"]}
            $0.secondOptions = { a in
                return [1, 2, 3]}
            $0.thirdOptions = { b, c in
                return ["week(s)","month(s)","year"]}
            $0.title = "Billing Cycle"
            $0.tag = "billingCycle"
            $0.value = .init(a: "Every", b: subscription.billingCycle.0, c: subscription.billingCycle.1)
        }.onChange{ [unowned self] row in
            
            self.subscription.billingCycle.0 = row.value?.b ?? 1
            self.subscription.billingCycle.1 = row.value?.c ?? "week(s)"
            
            print(row.value?.b)
            
            if(row.selectedC == row.value?.c){
                return
            }
            
            switch row.value?.c {
            case "week(s)":
                row.secondOptions = { _ in
                return [1,2,3,4,5,6]
            }
            case "month(s)":
                row.secondOptions = { _ in
                return [1,2,3,4,5,6,7,8,9,10,11,12]
            }
            case "year":
                row.secondOptions = { _ in
                return [1]
            }
            default:
                break
            }
            
            row.selectedC = row.value?.c
            row.value = .init(a: row.value?.a ?? "Every", b: 1, c: row.value?.c ?? "week(s)")
        }
        <<< MTriplePickerInputRow<String, String, String>() {
            $0.firstOptions = { return ["Never", "Same", "1", "2", "3", "4", "5", "6","7"]}
            $0.secondOptions = { a in
                return ["", "Day(s)"]}
            $0.thirdOptions = { b, c in
                return ["", "before"]}
            $0.title = "Remind"
            $0.tag = "remind"
            $0.value = .init(a: subscription.remind.0, b: subscription.remind.1, c: subscription.remind.2)
        }.onChange{ [unowned self] row in
            
            self.subscription.remind.0 = row.value?.a ?? "Never"
            self.subscription.remind.1 = row.value?.b ?? ""
            self.subscription.remind.2 = row.value?.c ?? ""
            
            switch row.value?.a {
                case "Never":
                    row.value = .init(a: "Never", b: "", c: "")
            default:
                row.value = .init(a: row.value?.a ?? "Same", b: "Day(s)", c: "before")
            }
        }
        <<< MCurrencyRow(){
            $0.title = "Currency"
            $0.tag = "currency"
            $0.selectorTitle = "Select currency"
            $0.noValueDisplayText = "Select a currency"
            $0.value = subscription.currency
            $0.onChange({[unowned self] row in
                if let currency = row.value {
                    self.subscription.currency = currency
                    self.subHeader.configure(with: self.subscription)
                }
                row.reload()
            })
        }
        
        //https://github.com/xmartlabs/Eureka/blob/master/README.md#row-catalog
    }
    
    
    func configure(with expense: Expense){
        subscription.name = expense.name
        subscription.category = expense.category
        subscription.color = expense.color
        subscription.logo = expense.logo
    }
    
    func configure(with sub: Subscription){
        subscription.name = sub.name
        subscription.category = sub.category
        subscription.color = sub.color
        subscription.logo = sub.logo
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
