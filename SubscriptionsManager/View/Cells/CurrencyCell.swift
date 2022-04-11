//
//  CurrencyCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 11/4/2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
    let currencyLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(currencyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        currencyLabel.sizeToFit()
        currencyLabel.frame = CGRect(x: 8, y: (contentView.height-currencyLabel.height)/2, width: currencyLabel.width, height: currencyLabel.height)
    }
    
    override func prepareForReuse() {
        currencyLabel.text = nil
    }
    
    
    func configure(with currency: String){
        currencyLabel.text = currency
    }

}
