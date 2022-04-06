//
//  SubscriptionViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 3/4/2022.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        table.backgroundColor = .red
        
        table.register(SubscriptionHeader .self, forHeaderFooterViewReuseIdentifier: SubscriptionHeader.identifier)
        table.register(EntryTableViewCell.self, forCellReuseIdentifier: EntryTableViewCell.identifier)
        return table
    }()
    
    var sections = [SubscriptionSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSectionsData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func addSectionsData(){
        sections = [
            SubscriptionSection(title: "Name", value: "nameValue"),
            SubscriptionSection(title: "Description", value: "desctiptionValue"),
            SubscriptionSection(title: "Category", value: "nameValue"),
            SubscriptionSection(title: "Next Bill", value: "nameValue"),
            SubscriptionSection(title: "Billing Cycle", value: "nameValue"),
            SubscriptionSection(title: "Remind", value: "nameValue"),
            SubscriptionSection(title: "Currency", value: "nameValue"),
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
 

}

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EntryTableViewCell.identifier,
            for: indexPath
        ) as? EntryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: EntryTableViewCellViewModel(
            name: model.title,
            value: model.value,
            placeHolder: model.title))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SubscriptionHeader.identifier)
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
    
    
}
