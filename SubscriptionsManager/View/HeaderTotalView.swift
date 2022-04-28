//
//  headerTotalView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 27/4/2022.
//

import UIKit

class HeaderTotalView: UIView {
    
    private let priceLb : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(priceLb)
     //   createSuitSegmentedControl()
        createSegmentedControl()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLb.backgroundColor = .green
        priceLb.frame = CGRect(x: (width-200)/2, y: 180, width: 200, height: 50)
        
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
    
    func createSegmentedControl(){
        let segControl = MSegmentedControl(
            frame: CGRect(x: 0, y: 240, width: 300, height: 50),
            buttonTitle: ["Average","Total","Pending"])
        addSubview(segControl)
        
    }
    
    func createSegmentedControl2(){
        let items = ["Average", "Total", "Pending"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.backgroundColor = .clear
        
        
        segmentedControl.addTarget(self, action: #selector(segDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    @objc func segDidChange(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex {
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
