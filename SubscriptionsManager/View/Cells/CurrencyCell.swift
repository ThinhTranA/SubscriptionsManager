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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(codeLb)
        addSubview(nameLb)
        addSubview(flagImg)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        codeLb.sizeToFit()
        nameLb.sizeToFit()
        flagImg.sizeToFit()
        
        flagImg.frame = CGRect(x: 12, y: (height-32)/2, width: 32, height: 32)
        codeLb.frame = CGRect(x: flagImg.right+12, y: (height-codeLb.height)/2, width: codeLb.width, height: codeLb.height)
        nameLb.frame = CGRect(x:codeLb.right+16, y: (height-nameLb.height)/2, width: nameLb.width, height: nameLb.height)
    }
    
    override func prepareForReuse() {
        codeLb.text = nil
    }
    
    
    func configure(with currency: Currency){
        codeLb.text = currency.code
        nameLb.text = currency.name
        
        print(currency.countryCode)
        let flag = Flag(countryCode: currency.countryCode)!
        flagImg.image = flag.image(style: .circle)
    }

}
