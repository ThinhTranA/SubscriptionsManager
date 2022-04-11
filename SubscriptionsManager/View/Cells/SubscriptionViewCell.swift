//
//  SubscriptionViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 3/4/2022.
//

import UIKit

class SubscriptionViewCell: UITableViewCell {
    static let identifier = "SubscriptionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let perMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let expiredLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Expired"
        //label.isHidden = true
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        return imageView
    }()
    
    override func prepareForReuse() {
        nameLabel.text = nil
        costLabel.text = nil
        perMonthLabel.text = nil
        expiredLabel.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(perMonthLabel)
        contentView.addSubview(expiredLabel)
        contentView.addSubview(logoImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        costLabel.sizeToFit()
        perMonthLabel.sizeToFit()
        expiredLabel.sizeToFit()
        
        logoImageView.frame = CGRect(x: 8,y: (contentView.height-60)/2, width: 60, height: 60)
        
        let logoImageViewRightPos = logoImageView.right+8
        nameLabel.frame = CGRect(
            x: logoImageViewRightPos,
            y: 16,
            width: nameLabel.width,
            height: nameLabel.height)
        
        costLabel.frame = CGRect(
            x: logoImageViewRightPos,
            y: nameLabel.bottom+4,
            width: costLabel.width,
            height: costLabel.height)
        perMonthLabel.frame = CGRect(
            x: contentView.width - perMonthLabel.width - 8,
            y: (contentView.height-perMonthLabel.height)/2,
            width: perMonthLabel.width,
            height: perMonthLabel.height)
        expiredLabel.frame = CGRect(
            x: (contentView.width-expiredLabel.width)/2,
            y:(contentView.height - expiredLabel.height)/2,
            width: expiredLabel.width,
            height: expiredLabel.height)
    }
    

    func configure(with viewModel: SubscriptionViewCellViewModel) {
        nameLabel.text = viewModel.name
        costLabel.text = viewModel.cost
        perMonthLabel.text = viewModel.perMonth
        
        if(viewModel.expiredDate < Date.now.addingTimeInterval(60*20) ){ //20 mins
            expiredLabel.isHidden = false
        }
    }

}
