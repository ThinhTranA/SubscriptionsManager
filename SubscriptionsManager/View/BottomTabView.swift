//
//  BottomTabView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 30/3/2022.
//

import UIKit

protocol BotomTabViewDelegate: AnyObject {
    func openSettings()
}

class BottomTabView: UIView {
    static let tabHeight: CGFloat = 70
    
    weak var delegate: BotomTabViewDelegate?

    private let settingImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "gear")
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .blue
        
        addSubview(settingImageView)
        let tapSettings = UITapGestureRecognizer(target: self, action: #selector(didTapSettings))
        settingImageView.isUserInteractionEnabled = true
        settingImageView.addGestureRecognizer(tapSettings)
    }
    
    @objc func didTapSettings(){
        print("did tap settings")
        delegate?.openSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingImageView.frame = CGRect(x:4, y: height-70+4, width: 40, height: 40)
    }


}
