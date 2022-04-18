//
//  CurrencyCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 11/4/2022.
//

import UIKit
import FlagKit

class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
    let codeLb: UILabel = {
       let lb = UILabel()
        lb.layer.opacity = 0.4
        return lb
    }()
    let nameLb: UILabel = UILabel()
    let flagImg: UIImageView = {
        let flagImg = UIImageView()
        return flagImg
    }()
    
    let isSelectedImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        img.backgroundColor = .lightGray.withAlphaComponent(0.2)
        img.layer.cornerRadius = 14
        img.contentMode = .center
        img.tintColor = .green.darker(by: 50)
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(codeLb)
        addSubview(nameLb)
        addSubview(flagImg)
        addSubview(isSelectedImg)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        codeLb.sizeToFit()
        nameLb.sizeToFit()
        flagImg.sizeToFit()
        isSelectedImg.sizeToFit()
        
        flagImg.frame = CGRect(x: 12, y: (height-32)/2, width: 32, height: 32)
        codeLb.frame = CGRect(x: flagImg.right+12, y: (height-codeLb.height)/2, width: codeLb.width, height: codeLb.height)
        nameLb.frame = CGRect(x:codeLb.right+16, y: (height-nameLb.height)/2, width: nameLb.width, height: nameLb.height)
        
        isSelectedImg.frame = CGRect(x: width-isSelectedImg.width-24, y: (height-28)/2, width: 24, height: 24)
    }
    
    override func prepareForReuse() {
        codeLb.text = nil
        isSelectedImg.isHidden = true
    }
    
    
    func configure(with currency: Currency, _ isSelected: Bool){
        codeLb.text = currency.code
        nameLb.text = currency.name
        let flag = Flag(countryCode: currency.countryCode)!
        flagImg.image = flag.image(style: .circle)
        
        isSelectedImg.isHidden = !isSelected
    }

}
