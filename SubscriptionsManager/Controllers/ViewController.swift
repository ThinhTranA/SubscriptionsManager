//
//  ViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 28/4/2022.
//

import Foundation
import UIKit

class ViewController : UIViewController {
    let countingLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let textLb: UILabel = {
       let lb = UILabel()
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countingLabel)
        view.addSubview(textLb)
        view.backgroundColor = .white
        //countingLabel.frame = view.frame
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        countingLabel.sizeToFit()
        countingLabel.frame = CGRect(x: (view.width-200)/2, y: (view.height-countingLabel.height)/2, width: 200, height: countingLabel.height)
        
        textLb.text = "aa"
        textLb.backgroundColor = .orange
        textLb.frame = CGRect(x: 50, y: countingLabel.bottom, width: view.width, height: 50)
    }
    
    let displayText = "Let's see how to go with text edffects with the fly trhough"
    let start:Double = 1
    
    var startValue: Double = 900
    let endValue: Double = 1000
    let animationDuration: Double = 3.5
    
    let animationStartDate = Date()
    
    @objc func handleUpdate(){
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.countingLabel.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.countingLabel.text = "\(value)"
        }
        
        
     
        
        
//        self.countingLabel.text = "\(startValue)"
//        startValue += 1
//
//        if startValue > endValue {
//            startValue = endValue
//        }
    }
}
