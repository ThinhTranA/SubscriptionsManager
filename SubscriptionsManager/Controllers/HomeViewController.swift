//
//  ViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 29/3/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var subsciptions = SubscriptionService.shared.getAllSubscriptions()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.text = "Your subscriptions will appear here"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    private let subsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SubscriptionViewCell.self, forCellReuseIdentifier: SubscriptionViewCell.identifier)
        
        return tableView
    }()
    
    private let bottomBar = BottomTabView()
    
    private let headerTotalView = HeaderTotalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        
        setupHeaderTotalView()
        setupNavigationBar()
        setupTableView()
        setupEmptySubPlaceholder()
        setupBottomBarView()
    }
    
    func setupHeaderTotalView(){
        view.addSubview(headerTotalView)
        headerTotalView.configure(with: subsciptions)
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView(){
        subsTableView.delegate = self
        subsTableView.dataSource = self
        view.addSubview(subsTableView)
    }
    
    private func setupEmptySubPlaceholder(){
        infoLabel.isHidden = subsciptions.count > 0
    }
    
    private func setupBottomBarView(){
        view.addSubview(bottomBar)
        bottomBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(
            x: 8,
            y: view.safeAreaInsets.top + 8,
            width: 150,
            height: 40
        )
        titleLabel.sizeToFit()
        
        infoLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 40
        )
        infoLabel.sizeToFit()
        
        bottomBar.frame = CGRect(
            x: 0,
            y: view.height-BottomTabView.tabHeight,
            width: view.width,
            height: BottomTabView.tabHeight
        )
        
        headerTotalView.frame = CGRect(x: 0, y: 0, width: view.width, height: 300)
        
        subsTableView.frame = CGRect(x: 0, y: headerTotalView.bottom, width: view.width, height: view.height-headerTotalView.height)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

}

extension HomeViewController: SubscriptionViewCellDelegate {
    func markAsPaid(subId: ObjectIdentifier) {
        //Display confirmation for next due date
        reloadAllSubscriptions()
    }
}

extension HomeViewController: BotomTabViewDelegate {
    func openSettings() {
        print("open settings")
        let settings = SettingsViewController()
        if let sheet = settings.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
        }
        
        present(settings, animated: true)
    }
    
    func addSubscription() {
        let vc = AddExpenseViewController()
        vc.addUpdateSubDelegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

extension HomeViewController: AddUpdateSubDelegate{
    func reloadAllSubscriptions() {
        subsciptions = SubscriptionService.shared.getAllSubscriptions()
        headerTotalView.configure(with: subsciptions, duration: 1)
        subsTableView.reloadData()
        infoLabel.isHidden = subsciptions.count > 0
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subsciptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionViewCell.identifier, for: indexPath)
                as? SubscriptionViewCell else {
            return UITableViewCell()
        }
        
        let sub = subsciptions[indexPath.row]
        cell.configure(with: SubscriptionViewCellViewModel(subscriptionObj: sub))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = AddUpdateSubViewController()
        let vm = AddUpdateSubViewModel(subObj: subsciptions[indexPath.row])
        vc.configure(with: vm)
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}

