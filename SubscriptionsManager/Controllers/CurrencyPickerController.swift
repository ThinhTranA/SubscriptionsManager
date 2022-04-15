//
//  CurrencyPickerController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import UIKit
import Eureka

open class CurrencyPickerController: UIViewController, TypedRowControllerType, UINavigationControllerDelegate, CurrencyPickerHeaderDelegate {
    
    public var row: RowOf<String>!
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    let tableView: UITableView = UITableView()
    var currencies: [String] = [String]()
    let allCurrencies: [String] = ["AU", "USD", "EU", "VND"]

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        
        CurrencyService.shared.getAllCurrencies()
    }
    
    open override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        currencies = allCurrencies
        tableView.separatorStyle = .none
        tableView.register(CurrencyPickerHeader.self, forHeaderFooterViewReuseIdentifier: CurrencyPickerHeader.identifier)
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    public func cancel() {
        dismiss(animated: true)
    }
    
    public func filterCurrency(with word: String) {
        print(word)
        if(word != ""){
            currencies = allCurrencies.filter{ row in
                row.lowercased().contains(word.lowercased())
            }
        } else {
            currencies = allCurrencies
        }
        tableView.reloadData()
    }
}

extension CurrencyPickerController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath)
            as? CurrencyCell
        {
            cell.configure(with: currencies[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        row.value = currency
        row.updateCell()
        guard let callback = self.onDismissCallback else{ return }
        callback(self)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CurrencyPickerHeader.identifier) as? CurrencyPickerHeader {
            header.delegate = self
            return header
        }
        return nil
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56
    }
    
    
    
}
