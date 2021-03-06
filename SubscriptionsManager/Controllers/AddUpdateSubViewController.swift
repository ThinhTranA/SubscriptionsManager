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
    
    var viewModel : AddUpdateSubViewModel = AddUpdateSubViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let customSubHeader: AddUpdateSubHeader = {
        let addUpdateHeader = AddUpdateSubHeader()
        addUpdateHeader.sizeToFit()
        return addUpdateHeader
    }()
    
    private var formHeader: HeaderFooterView<UIView>?
    
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

        customSubHeader.delegate = self
        configureDeleteBtn()
        configureNavigationBar()
        configureSubscriptionForm()
        configureBackgroundsColor()
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
    
    private func configureBackgroundsColor(){
        navigationController?.navigationBar.barTintColor = viewModel.color
        tableView.backgroundColor = viewModel.color
    }
    
    private func configureNavigationBar(){
        title = viewModel.name
        
        let newBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 24))
        newBtn.setTitle("Save", for: .normal)
        newBtn.setTitleColor(viewModel.color, for: .normal)
        newBtn.titleLabel?.font = .systemFont(ofSize: 14)
        newBtn.layer.cornerRadius = 14
        newBtn.clipsToBounds = false
        newBtn.backgroundColor = M.Colors.white
        newBtn.addTarget(self, action: #selector(didTapSaveBtn), for: .touchUpInside)
        
        let changeColorBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 24))
        changeColorBtn.isHidden = true
        changeColorBtn.setTitle("Color", for: .normal)
        changeColorBtn.setTitleColor(viewModel.color, for: .normal)
        changeColorBtn.titleLabel?.font = .systemFont(ofSize: 14)
        changeColorBtn.layer.cornerRadius = 14
        changeColorBtn.clipsToBounds = false
        changeColorBtn.backgroundColor = M.Colors.white
        changeColorBtn.addTarget(self, action: #selector(didTapColorBtn), for: .touchUpInside)
        if(viewModel.name.isEmpty){
            changeColorBtn.isHidden = false
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newBtn)
        navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: newBtn), UIBarButtonItem(customView: changeColorBtn)]
        
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
        viewModel.price = Decimal(string: customSubHeader.costTxtField.text ?? "") ?? 0 
        let isValidForm = validateForm()
        if(!isValidForm) {
            return
        }
        viewModel.saveSubscription()
        viewModel.updateRemindNotification(vc: self)
        
        dismissAndReloadData()
    }
    
    @objc func didTapDeleteBtn(){
        viewModel.deleteSubscription()
        dismissAndReloadData()
    }
    
    @objc func didTapColorBtn(){
        let vc = ColorPickerViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func validateForm() -> Bool{
        view.endEditing(false)
        if(viewModel.name.isEmpty){
            let alert = UIAlertController(title: "Subscription", message: "You need to add a Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if(viewModel.price <= 0){
            customSubHeader.validationMessageLb.isHidden = false
            customSubHeader.setNeedsLayout()
            return false
        }
        
        return true
    }
    
    private func dismissAndReloadData(){
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
        delegate?.reloadAllSubscriptions()
    }
    
    
    private func configureSubscriptionForm(){
        
        
        form +++ Section() { section in
            section.header = { [unowned self] in
                self.formHeader = HeaderFooterView<UIView>(.callback({ [unowned self] in
                    self.customSubHeader.configure(with: self.viewModel)
                    return self.customSubHeader
                }))
                self.formHeader?.height = { 260 }
                return self.formHeader
            }()
        }
        <<< MTextRow(){
            $0.title = "Name"
            $0.add(rule: RuleRequired())
            $0.placeholder = "Add a name"
            $0.value = viewModel.name
        }.onChange{[unowned self] row in self.viewModel.name = row.value ?? ""}
        <<< MTextRow(){
            $0.title = "Description"
            $0.tag = "description"
            $0.placeholder = "Add a description"
            $0.value = viewModel.subDescription
        }.onChange{[unowned self] row in self.viewModel.subDescription = row.value ?? ""}
        <<< MCategoryRow(){
            $0.title = "Category"
            $0.tag = "category"
            $0.noValueDisplayText = "Choose a Cagetory"
            $0.value = viewModel.category
        }.onChange{[unowned self] row in self.viewModel.category = row.value ?? ""}
        <<< MDateRow(){
            $0.title = "Next Bill"
            $0.tag = "nextBill"
            $0.value = viewModel.nextBill
            if $0.value == nil {
                $0.value = Date()
            }
        }.onChange{[unowned self] row in self.viewModel.nextBill = row.value!}
        <<< MTriplePickerInputRow<String, Int, BillingCycleUnit>() {
            $0.firstOptions = { return ["Every"]}
            $0.secondOptions = { a in
                return [1, 2, 3]}
            $0.thirdOptions = { b, c in
                return [.week,.month,.year]}
            $0.title = "Billing Cycle"
            $0.tag = "billingCycle"
            $0.value = .init(a: "Every", b: viewModel.billingCycle.quantity, c: viewModel.billingCycle.unit)
            
            
        }.onChange{ [unowned self] row in
            
            self.viewModel.billingCycle.quantity = row.value?.b ?? 1
            self.viewModel.billingCycle.unit = row.value?.c ?? .week
            if let vl = row.value {
                let qty = vl.b
                let sStr = "\(qty > 1 ? "s" : "")"
                row.displayString =  String(describing: vl.a) + " "
                + String(describing: vl.b) + " "
                + String(describing: vl.c)
                + sStr
            }
            
            if(row.selectedC == row.value?.c){
                return
            }
            
            switch row.value?.c {
            case .week:
                row.secondOptions = { _ in
                return [1,2,3,4,5,6]
            }
            case .month:
                row.secondOptions = { _ in
                return [1,2,3,4,5,6,7,8,9,10,11,12]
            }
            case .year:
                row.secondOptions = { _ in
                return [1]
            }
            default:
                break
            }
            
            row.selectedC = row.value?.c
            row.value = .init(a: row.value?.a ?? "Every", b: 1, c: row.value?.c ?? .week)
            
          
        }
        <<< MTriplePickerInputRow<String, String, String>() {
            $0.firstOptions = { return Remind.allValues}
            $0.secondOptions = { a in
                return ["", Remind.dayDefaultValue]}
            $0.thirdOptions = { b, c in
                return ["", Remind.beforeDefaultValue]}
            $0.title = "Remind"
            $0.tag = "remind"
            $0.value = .init(a: viewModel.remind.time, b: viewModel.remind.day, c: viewModel.remind.before)
        }.onChange{ [unowned self] row in
            
            self.viewModel.remind.time = row.value?.a ?? Remind.timeDefaultValue
            self.viewModel.remind.day = row.value?.b ?? Remind.dayDefaultValue
            self.viewModel.remind.before = row.value?.c ?? Remind.beforeDefaultValue
            
            switch row.value?.a {
                case "Never":
                    row.value = .init(a: "Never", b: "", c: "")
            default:
                row.value = .init(a: row.value?.a ?? "Same", b: "Day(s)", c: "before")
            }
        }
        <<< MCurrencyRow(){
            $0.title = "Currency"
            $0.selectorTitle = "Select currency"
            $0.noValueDisplayText = "Select a currency"
            $0.value = viewModel.currency
            $0.onChange({[unowned self] row in
                if let currency = row.value {
                    self.viewModel.currencyCode = currency.code
                    self.customSubHeader.configure(with: self.viewModel)
                }
                row.reload()
            })
        }
        
        //https://github.com/xmartlabs/Eureka/blob/master/README.md#row-catalog
    }
    
    
    func configure(with expense: Expense){
        viewModel.name = expense.name
        viewModel.category = expense.category
        viewModel.colorHex = expense.colorHex
        viewModel.logo = expense.logo
        viewModel.isCustom = expense.isCustom
    }
    
    func configure(with vm: AddUpdateSubViewModel){
        viewModel = vm
    }
    
}

extension AddUpdateSubViewController: AddUpdateSubHeaderDelegate {
    func changeCustomLogo() {
        let vc = EmojiLogoPickerViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

extension AddUpdateSubViewController: EmojiLogoPickerDelegate {
    func saveCustomizeIcon(emoji: String) {
        viewModel.logo = emoji
        customSubHeader.configure(with: viewModel)
    }
}

extension AddUpdateSubViewController: ColorPickerDelegate{
    func saveColor(colorHex: String) {
        viewModel.colorHex = colorHex
        customSubHeader.configure(with: viewModel)
        configureBackgroundsColor()
        dismiss(animated: true)
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
