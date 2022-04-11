//
//  CurrencyPickerController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import UIKit
import Eureka

open class CurrencyPickerController: UIViewController, TypedRowControllerType, UINavigationControllerDelegate {
    
    public var row: RowOf<String>!
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    let tableView: UITableView = UITableView()
    let currencies: [String] = ["AU", "USD", "EU"]

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    open override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
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
    
    
}
