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
       // imageView.tintColor = .blue
        return imageView
    }()
    private let creditCard2Image: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "creditcard")
        return imageView
    }()
    
    private let bottomBar = BottomTabView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(creditCard2Image)
        view.addSubview(creditCard1Image)
        
        setupBottomBarView()
    }
    
    private func setupBottomBarView(){
        view.addSubview(bottomBar)
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
    }
    


}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}

