//
//  headerTotalView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 27/4/2022.
//

import UIKit

enum PriceType {
    case average
    case total
    case pending
    
    var title: String {
        switch self {
        case .average: return "Monthly Average"
        case .total: return "Monthly Total"
        case .pending: return "Montly Pending"
        }
    }
}

class HeaderTotalView: UIView, MSegmentedControlDelegate {
    
    private let priceLb : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = M.Colors.white
        lb.font = .systemFont(ofSize: 36, weight: .semibold)
        return lb
    }()
    
    private let segControl: MSegmentedControl = {
        let segControl = MSegmentedControl(
            frame: CGRect(x: 0, y: 240, width: 280, height: 50),
            buttonTitle: ["Average","Total","Pending"])
        segControl.textColor = M.Colors.greyWhite
        segControl.selectorTextColor = .white
        return segControl
    }()
    
    private var priceType: PriceType = .average
    private var subscriptions: [Subscription]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(priceLb)
        addSubview(segControl)
        segControl.delegate = self
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLb.frame = CGRect(x: 0, y: 180, width: width, height: 50)
        
        segControl.frame = CGRect(x: (width-segControl.width)/2, y: height-segControl.height-8, width: segControl.width, height: segControl.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let startValue: Double = 1
    private var endValue: Double = 0
    private var animationStartDate = Date()
    private var animationDuration: Double = 1
    @objc func handleUpdate(){
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.priceLb.text = "\(endValue.priceString)$"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.priceLb.text = String(format: "%.2f$", value)
        }
    }
    
    func segSelectedIndexChange(to index: Int) {
        switch index {
        case 0:
            priceType = .average
        case 1: priceType = .total
        case 2: priceType = .pending
        default: break
        }
        
        if let subs = subscriptions {
            configure(with: subs)
        }
    }
    
    
    func configure(with totalCost: Double, duration seconds: Double = 1){
        endValue = totalCost
        //reset animation
        animationDuration = seconds
        animationStartDate = Date()
    }
    
    func configure(with subs: [Subscription], duration seconds: Double = 1){
        subscriptions = subs
        let totalCost: Decimal
        // TODO: Calculate these
        switch priceType {
        case .average:
            totalCost = subs.map{$0.price}.reduce(0.0, +) + 8 //
        case .total:
            totalCost = subs.map{$0.price}.reduce(0.0, +) + 139 //Just to mock the diff
        case .pending:
            totalCost = subs.map{$0.price}.reduce(0.0, +) - 7 // mock
        }
        endValue = Double(truncating: totalCost as NSNumber)
        //reset animation
        animationDuration = seconds
        animationStartDate = Date()
    }
    
}
