//
//  headerTotalView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 27/4/2022.
//

import UIKit
import Eureka

enum TotalType {
    case monthly
    case yearly
    case weekly
    
    var title: String {
        switch self {
        case .monthly: return "Monthly Average"
        case .yearly: return "Yearly Average"
        case .weekly: return "Weekly Average"
        }
    }
}

class HeaderTotalView: UIView, MSegmentedControlDelegate {
    
    private let titleLb: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = M.Colors.white
        lb.font = .systemFont(ofSize: 28, weight: .semibold)
        lb.text = "Subscriptions"
        return lb
    }()
    
    private let descriptionLb: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = M.Colors.greyWhite
        lb.font = .systemFont(ofSize: 18)
        return lb
    }()
    
    private let priceLb : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = M.Colors.white
        lb.font = .systemFont(ofSize: 44, weight: .semibold)
        return lb
    }()
    
    private let segControl: MSegmentedControl = {
        let segControl = MSegmentedControl(
            frame: CGRect(x: 0, y: 240, width: 280, height: 50),
            buttonTitle: ["Month","Year","Week"])
        segControl.textColor = M.Colors.greyWhite
        segControl.selectorTextColor = .white
        return segControl
    }()
    
    private var totalType: TotalType = .monthly
    private var subscriptions: [SubscriptionCD]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = M.Colors.primaryColor
        addSubview(titleLb)
        addSubview(descriptionLb)
        addSubview(priceLb)
        addSubview(segControl)
        segControl.delegate = self
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLb.sizeToFit()
        titleLb.frame = CGRect(x: 8, y: 48, width: titleLb.width, height: titleLb.height)
        priceLb.frame = CGRect(x: 0, y: 128, width: width, height: 50)
        descriptionLb.sizeToFit()
        descriptionLb.frame = CGRect(x: (width-descriptionLb.width)/2, y: priceLb.bottom+8, width: descriptionLb.width, height: descriptionLb.height)
        
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
        
        if elapsedTime > animationDuration || endValue < 0.001{
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
            totalType = .monthly
        case 1: totalType = .yearly
        case 2: totalType = .weekly
        default: break
        }
        
        if let subs = subscriptions {
            configure(with: subs)
        }
    }
    
    
    func configure(with totalCost: Double, duration seconds: Double = 0.5){
        endValue = totalCost
        resetAnimation(duration: seconds)
    }
    
    func configure(with subs: [SubscriptionCD], duration seconds: Double = 0.5){
        subscriptions = subs
        let totalCost: Decimal
        switch totalType {
        case .monthly:
            totalCost = subs.map{$0.monthlyPrice as Decimal}.reduce(0.0, +)
            descriptionLb.text = "Monthy average"
        case .yearly:
            totalCost = subs.map{$0.yearlyPrice as Decimal}.reduce(0.0, +)
            descriptionLb.text = "Yearly average"
        case .weekly:
            totalCost = subs.map{$0.weeklyPrice as Decimal}.reduce(0.0, +)
            descriptionLb.text = "Weekly average"
        }
        endValue = Double(truncating: totalCost as NSNumber)
        
        resetAnimation(duration:seconds)
        if(endValue < 0.001) {
            descriptionLb.text = "Add your first expense"
        }
        descriptionLb.sizeToFit()
    }
    
    private func resetAnimation(duration seconds: Double = 0.5){
        animationDuration = seconds
        animationStartDate = Date()
    }
    
}
