//
//  AddExpenseViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        //remove 2 seperator lines
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search your services..."
        return searchBar
    }()
    
    
    private let popularExpensesTb: UITableView = {
       let tableView = UITableView()
        tableView.register(ExpenseViewCell.self, forCellReuseIdentifier: ExpenseViewCell.identifier)
        tableView.separatorInset.right = tableView.separatorInset.left
        return tableView
    }()
    
    private var expenses: [Expense] = ExpenseService.shared.getAllExpenses()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add expenses"
        configureSearchBar()
        configureTableView()
    }
    
    private func configureSearchBar(){
        view.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    private func configureTableView(){
        view.addSubview(popularExpensesTb)
        popularExpensesTb.tableHeaderView = searchBar
        popularExpensesTb.delegate = self
        popularExpensesTb.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popularExpensesTb.frame = view.bounds
    }
}

extension AddExpenseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let allExpenses = ExpenseService.shared.getAllExpenses()
        if(searchText != ""){
            expenses = allExpenses.filter{ expense in
                expense.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            expenses = allExpenses
        }
        popularExpensesTb.reloadData()
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
        64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
