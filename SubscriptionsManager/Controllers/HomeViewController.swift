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
        label.text = "Manage your subscriptions"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let creditCard1Image: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard")
        return imageView
    }()
    private let creditCard2Image: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard")
        return imageView
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
        title = "Expense"
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
        headerTotalView.configure(with: 3000)
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let newBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 24))
//        newBtn.setTitle("New", for: .normal)
//        newBtn.setTitleColor(.white, for: .normal)
//        newBtn.titleLabel?.font = .systemFont(ofSize: 14)
//        newBtn.layer.cornerRadius = 14
//        newBtn.clipsToBounds = true
//        newBtn.backgroundColor = .green
//        newBtn.addTarget(self, action: #selector(didTapNewBtn), for: .touchUpInside)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newBtn)
//        let closeBtn = UIBarButtonItem(
//            image: UIImage(systemName: "xmark"),
//            style: .done,
//            target: self,
//            action: #selector(didTapCloseBtn))
//        closeBtn.tintColor = .black
       // navigationItem.leftBarButtonItem = closeBtn
    }
    
    private func setupTableView(){
        subsTableView.delegate = self
        subsTableView.dataSource = self
        view.addSubview(subsTableView)
    }
    
    private func setupEmptySubPlaceholder(){
        return
        
        //TODO: use actual image instead of credit card system image
        view.addSubview(infoLabel)
        view.addSubview(creditCard2Image)
        view.addSubview(creditCard1Image)
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
        
        let creditCardWidth = view.bounds.width * 2/3
        let creditCardHeight = creditCardWidth*2/3
        let creditCardFrame = CGRect(
            x: creditCardWidth/4,
            y: view.bounds.height/2 - creditCardHeight,
            width: creditCardWidth,
            height: creditCardHeight
        )
            
        creditCard1Image.frame = creditCardFrame
        creditCard2Image.frame = creditCardFrame
        creditCard2Image.setAnchorPoint(CGPoint(x: 0, y: 1))
        creditCard2Image.transform = creditCard2Image.transform.rotated(by: -.pi/12)
        
        infoLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 40
        )
        let infoLabelCenter = CGPoint(x: view.center.x, y: creditCard1Image.center.y + creditCardHeight/2 + 24)
        infoLabel.center = infoLabelCenter
        infoLabel.sizeToFit()
        
        bottomBar.frame = CGRect(
            x: 0,
            y: view.height-BottomTabView.tabHeight,
            width: view.width,
            height: BottomTabView.tabHeight
        )
        
        headerTotalView.frame = CGRect(x: 0, y: 0, width: view.width, height: 300)
        
        subsTableView.frame = CGRect(x: 0, y: headerTotalView.bottom, width: view.width, height: view.height-headerTotalView.height)
        subsTableView.backgroundColor = .green
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(SubscriptionService.shared.getAllSubscriptions())
    }
    

}

extension HomeViewController: SubscriptionViewCellDelegate {
    func markAsPaid(subId: String) {
        SubscriptionService.shared.markSubscriptionAsPaid(subId)
        //Display confirmation for next due date
        reloadAllSubscriptions()
    }
}

extension HomeViewController: BotomTabViewDelegate {
    func openSettings() {
        print("open settings")
        
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
        headerTotalView.configure(with: 5392.20, duration: 1)
        subsTableView.reloadData()
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
        cell.configure(with: SubscriptionViewCellViewModel(
            subId: sub.id,
            name: sub.name,
            logo: sub.logoDefault,
            cost: sub.costString,
            dueDate: sub.dueDateString,
            isOverDue: sub.isOverdue)
        )
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = subsciptions[indexPath.row]
        print("\(text) row selected")
        
        let vc = AddUpdateSubViewController()
        vc.configure(with: subsciptions[indexPath.row])
        vc.subscription = subsciptions[indexPath.row]
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}

