//
//  SettingsViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 14/5/2022.
//

import UIKit

class SettingsViewCell: UITableViewCell {

    static let identifier = "SettingsViewCell"
    static private let leftImgPadding = 48.0
    
    private let iconImg: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .black
        return imgView
    }()

    private let settingsLb : UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    
    private let settingsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.contentHorizontalAlignment = .left
        btn.backgroundColor = .clear
        btn.showsMenuAsPrimaryAction = true
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leftImgPadding, bottom: 0, trailing: 0   )
        btn.configuration = configuration
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(iconImg)
        addSubview(settingsLb)
        contentView.addSubview(settingsBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingsLb.text = nil
        settingsBtn.menu = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImg.sizeToFit()
        iconImg.frame = CGRect(x: 8, y: (height-28)/2, width: 28, height: 28)
        settingsLb.sizeToFit()
        settingsLb.frame = CGRect(x: SettingsViewCell.leftImgPadding, y: (height-settingsLb.height)/2, width: settingsLb.width, height: settingsLb.height)
        settingsBtn.sizeToFit()
        settingsBtn.frame = bounds
    }
    
    func configure(with settings: SettingsOption){
        iconImg.image = settings.icon
        settingsLb.text = settings.title
        settingsBtn.setTitle(settings.title, for: .normal)
        
        if let menu = settings.menu {
            settingsBtn.menu = menu
            settingsLb.isHidden = true
            settingsBtn.isHidden = false
        } else {
            settingsLb.isHidden = false
            settingsBtn.isHidden = true
        }
        
    }
    
}
