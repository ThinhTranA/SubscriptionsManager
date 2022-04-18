//
//  CategoryPickerViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 18/4/2022.
//

import UIKit
import Eureka

open class CategoryPickerViewController: UIViewController, TypedRowControllerType, UINavigationControllerDelegate, CategoryPickerHeaderDelegate {
    
    public var row: RowOf<String>!
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    let tableView: UITableView = UITableView()
    
    //TODO: Add custom category & ablity remove default category , store in user preference maybe!
    let categories = [
        CategoryRowViewModel(category: "Transport", categoryImg: "bus.fill", categoryImgColor: .orange),
        CategoryRowViewModel(category: "Entertainment", categoryImg: "gamecontroller.fill", categoryImgColor: .red.withAlphaComponent(0.8)),
        CategoryRowViewModel(category: "Education", categoryImg: "graduationcap.fill", categoryImgColor: .magenta),
        CategoryRowViewModel(category: "Insurance", categoryImg: "shield.fill", categoryImgColor: .cyan.withAlphaComponent(0.8)),
        CategoryRowViewModel(category: "Music", categoryImg: "music.note", categoryImgColor: .brown),
        CategoryRowViewModel(category: "Utilities", categoryImg: "house", categoryImgColor: .link),
        CategoryRowViewModel(category: "Food & Beverages", categoryImg: "fork.knife", categoryImgColor: .purple),
        CategoryRowViewModel(category: "Health & Wellbeing", categoryImg: "heart.fill", categoryImgColor: .green),
        CategoryRowViewModel(category: "Productivity", categoryImg: "briefcase", categoryImgColor: .yellow),
        CategoryRowViewModel(category: "Banking", categoryImg: "banknote", categoryImgColor: .green.withAlphaComponent(0.7)),
    ]

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
        tableView.separatorStyle = .none
        tableView.register(CategoryPickerHeader.self, forHeaderFooterViewReuseIdentifier: CategoryPickerHeader.identifier)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    public func cancel() {
        dismiss(animated: true)
    }
    
   
}

extension CategoryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
            as? CategoryCell
        {
            let cVM = categories[indexPath.row]
            cell.configure(with: cVM, row.value == cVM.category)
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        row.value = category.category
        row.updateCell()
        guard let callback = self.onDismissCallback else{ return }
        callback(self)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryPickerHeader.identifier) as? CategoryPickerHeader {
            header.delegate = self
            return header
        }
        return nil
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56
    }
    
}
