//
//  AddExpenseViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    private let popularExpensesTb: UITableView = {
       let tableView = UITableView()
        tableView.register(ExpenseViewCell.self, forCellReuseIdentifier: ExpenseViewCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        return tableView
    }()
    
    private let expenses: [Expense] = ExpenseService.shared.getAllExpenses()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add expenses"
        configureTableView()
    }
    
    private func configureTableView(){
        view.addSubview(popularExpensesTb)
        popularExpensesTb.delegate = self
        popularExpensesTb.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popularExpensesTb.frame = view.bounds
    }
}

extension AddExpenseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseViewCell.identifier)
            as? ExpenseViewCell {
            let expense = expenses[indexPath.row]
            cell.configure(with: expense)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
