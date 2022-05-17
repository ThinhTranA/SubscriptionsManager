//
//  ViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 13/5/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let currencyLb: MLabel = {
        let lb = MLabel(withInsets: 2, 2, 16, 16)
        lb.addLeading(
            image: UIImage(systemName: "info.circle")!.withTintColor(.white),
            text: "You need to add a price")
        return lb
    }()
    
    private let tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingsViewCell.self, forCellReuseIdentifier: SettingsViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0 )
        return tableView
    }()
    
    private var sections = [SettingsSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //view.addSubview(currencyLb)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //currencyLb.sizeToFit()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        //reset
        sections = [SettingsSection]()
        let currencyCode = UserReferenceService.shared.currencyCode
        let darkModeMenu = UIMenu(title: "", children:  Theme.allValues.map { theme in
            UIAction(title: theme.description, image: theme.icon, handler: { _ in ThemeService.shared.setTheme(to: theme)})
        })
        sections.append(SettingsSection(title: "Options", options: [
            SettingsOption(title: "Default currency: \(currencyCode)", icon: .init(systemName: "dollarsign.circle"), handler: { [weak self] in
                let currencyVc = CurrencyPickerController()
                func dismissCurrencyVC(currencyCode: String) {
                    UserReferenceService.shared.currencyCode = currencyCode
                    self?.configureModels()
                    self?.tableView.reloadData()
                    self?.dismiss(animated: true)
                }
                currencyVc.onDismissCallbackWithCurrenyCode = dismissCurrencyVC
                self?.present(currencyVc, animated: true)
            }),
            SettingsOption(title: "Dark mode disabled", icon: .init(systemName: "rays"), accessoryIcon: .init(systemName: "chevron.down"), menu: darkModeMenu, handler: nil)
        ]))
        
        sections.append(SettingsSection(title: "About", options: [
            SettingsOption(title: "Leave app review", icon: .init(systemName: "car"), handler: { [weak self] in
                self?.dismiss(animated: true)
            }),
            SettingsOption(title: "Privacy policy", icon: .init(systemName: "car"), handler: { [weak self] in
                self?.dismiss(animated: true)
            })
        ]))
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.identifier)
            as? SettingsViewCell {
            cell.configure(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Call handler for cell
        let model = sections[indexPath.section].options[indexPath.row]
        if let _ = model.handler {
            (model.handler!())
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
}
