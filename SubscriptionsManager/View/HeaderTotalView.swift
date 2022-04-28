//
//  headerTotalView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 27/4/2022.
//

import UIKit

class HeaderTotalView: UIView, MSegmentedControlDelegate {
 
    
    private let priceLb : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
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
        priceLb.backgroundColor = .green
        priceLb.frame = CGRect(x: (width-200)/2, y: 180, width: 200, height: 50)
        
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
            self.priceLb.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.priceLb.text = String(format: "%.2f", value)
        }
    }
    
    func segSelectedIndexChange(to index: Int) {
        switch index {
        case 0: print("Average")
        case 1: print("Total")
        case 2: print("Pending")
        default: break
        }
    }

    
    func configure(with totalCost: Double, duration seconds: Double = 1){
        endValue = totalCost
        //reset animation
        animationDuration = seconds
        animationStartDate = Date()
    }
    
    
}
