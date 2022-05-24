//
//  SubscriptionViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 3/4/2022.
//

import UIKit

protocol SubscriptionViewCellDelegate: AnyObject {
    func markAsPaid(subId: ObjectIdentifier)
}

class SubscriptionViewCell: UITableViewCell {
    static let identifier = "SubscriptionViewCell"
    
    var delegate: SubscriptionViewCellDelegate?
    private var subId: ObjectIdentifier?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
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
        label.textColor = .label
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
    
    private let logoEmojiView: UILabel = {
        let lb = UILabel()
        lb.isHidden = true
        lb.font = .systemFont(ofSize: 42)
        return lb
    }()
    
    private let overdueView: UIView = {
        let view = UIView()
        view.backgroundColor = M.Colors.primaryDark
        view.layer.opacity = 0.9
        view.isHidden = true
        return view
    }()
    
    private let expiredLabel: UILabel = {
       let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lb.textColor = .white
        lb.text = "Expired"
        lb.isHidden = true
        return lb
    }()

    override func prepareForReuse() {
        nameLabel.text = nil
        dueInLb.text = nil
        costLb.text = nil
        expiredLabel.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(dueInLb)
        contentView.addSubview(costLb)
        contentView.addSubview(logoImageView)
        contentView.addSubview(logoEmojiView)
        contentView.addSubview(overdueView)
        contentView.addSubview(expiredLabel)
        contentView.layer.cornerRadius = 0
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
        logoEmojiView.frame = logoImageView.frame
        
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
      
        overdueView.frame = contentView.bounds
        expiredLabel.sizeToFit()
        expiredLabel.frame = CGRect(x: (width-expiredLabel.width)/2, y: (height-expiredLabel.height)/2, width: expiredLabel.width+32, height: expiredLabel.height)
        

    }
    
    func configure(with viewModel: SubscriptionViewCellViewModel) {
        subId = viewModel.subId
        nameLabel.text = viewModel.name
        dueInLb.text = viewModel.dueDate
        costLb.text = viewModel.cost
        logoImageView.image = UIImage(named: viewModel.logo)
        logoEmojiView.text = viewModel.logo
        overdueView.isHidden = !viewModel.isOverDue
        expiredLabel.isHidden = !viewModel.isOverDue
        
        if(viewModel.isCustom){
            logoImageView.isHidden = true
            logoEmojiView.isHidden = false
        }
    }
    
    @objc func didTapMarkAsPaid(){
        if let id = subId{
            delegate?.markAsPaid(subId: id)
        }
    }

}
