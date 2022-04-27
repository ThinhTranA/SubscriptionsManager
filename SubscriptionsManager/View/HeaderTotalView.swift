//
//  headerTotalView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 27/4/2022.
//

import UIKit

class HeaderTotalView: UIView {
    
    private let averageBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Average", for: .normal)
        return btn
    }()
    
    private let totalBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Total", for: .normal)
        return btn
    }()
    
    private let pendingBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Pendin", for: .normal)
        return btn
    }()
    
    private let priceLb : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(averageBtn)
        addSubview(totalBtn)
        addSubview(pendingBtn)
        addSubview(priceLb)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLb.backgroundColor = .green
        priceLb.frame = CGRect(x: (width-200)/2, y: 180, width: 200, height: 50)
        
        pendingBtn.sizeToFit()
        averageBtn.sizeToFit()
        totalBtn.sizeToFit()
        
        averageBtn.frame = CGRect(x: 30, y: height-averageBtn.height-16, width: averageBtn.width, height: averageBtn.height)
        totalBtn.frame = CGRect(x: averageBtn.right, y: height-totalBtn.height-16, width: totalBtn.width, height: totalBtn.height)
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
            self.priceLb.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.priceLb.text = String(format: "%.2f", value)
        }
    }
    
    func configure(with totalCost: Double, duration seconds: Double = 1){
        endValue = totalCost
        //reset animation
        animationDuration = seconds
        animationStartDate = Date()
    }
    
}
