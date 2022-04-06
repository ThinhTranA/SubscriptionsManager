//
//  ViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 29/3/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    
    let myData = ["first", "sercond", "third"]
    private let subsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SubscriptionViewCell.self, forCellReuseIdentifier: SubscriptionViewCell.identifier)
        return tableView
    }()
    
    private let bottomBar = BottomTabView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        
        subsTableView.delegate = self
        subsTableView.dataSource = self
        view.addSubview(subsTableView)
        
        setupEmptySubPlaceholder()
        setupBottomBarView()
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
        
        subsTableView.frame = view.bounds
    }

}

extension HomeViewController: BotomTabViewDelegate {
    func openSettings() {
        print("open settings")
        
    }
    
    func addSubscription() {
        print("add sub")
        let vc = SubscriptionViewController()
        vc.title = "Add Subscription"
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionViewCell.identifier, for: indexPath)
                as? SubscriptionViewCell else {
            return UITableViewCell()
        }
        
        let text = myData[indexPath.row]
        cell.configure(with: SubscriptionViewCellViewModel(
            name: text,
            cost: "$90",
            perMonth: "10$ per month",
            expiredDate: Date.now.addingTimeInterval(40000))
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = myData[indexPath.row]
        print("\(text) row selected")
        // TODO:
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

