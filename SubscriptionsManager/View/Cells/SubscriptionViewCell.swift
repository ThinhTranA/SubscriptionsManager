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
    
    private let dueInLb: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let costLb: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    
    private let logoImageView: UIImageView = {
        let categoryImg = UIImageView()
        categoryImg.backgroundColor = .lightGray.withAlphaComponent(0.2)
        categoryImg.layer.cornerRadius = 20
        categoryImg.contentMode = .scaleAspectFit
        categoryImg.clipsToBounds = true
        categoryImg.backgroundColor = .clear
        return categoryImg
    }()
    
    override func prepareForReuse() {
        nameLabel.text = nil
        dueInLb.text = nil
        costLb.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(dueInLb)
        contentView.addSubview(costLb)
        contentView.addSubview(logoImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.sizeToFit()
        nameLabel.sizeToFit()
        dueInLb.sizeToFit()
        costLb.sizeToFit()
        
        logoImageView.frame = CGRect(x: 12, y: (height-40)/2, width: 40, height: 40)
        
        let logoImageViewRightPos = logoImageView.right+12
        nameLabel.frame = CGRect(
            x: logoImageViewRightPos,
            y: 16,
            width: nameLabel.width,
            height: nameLabel.height)
        
        dueInLb.frame = CGRect(
            x: logoImageViewRightPos,
            y: nameLabel.bottom+4,
            width: dueInLb.width,
            height: dueInLb.height)
        costLb.frame = CGRect(
            x: contentView.width - costLb.width - 12,
            y: (contentView.height-costLb.height)/2,
            width: costLb.width,
            height: costLb.height)
      
    }
    

    func configure(with viewModel: SubscriptionViewCellViewModel) {
        nameLabel.text = viewModel.name
        dueInLb.text = viewModel.dueDate
        costLb.text = viewModel.cost
        logoImageView.image = UIImage(named: viewModel.logo)
    }

}
