//
//  SubscriptionViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 3/4/2022.
//

import UIKit

protocol SubscriptionViewCellDelegate: AnyObject {
    func markAsPaid(subId: UUID)
}

class SubscriptionViewCell: UITableViewCell {
    static let identifier = "SubscriptionViewCell"
    
    var delegate: SubscriptionViewCellDelegate?
    private var subId: UUID?
    
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
    
    private let overdueView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.opacity = 0.3
        view.isHidden = true
        return view
    }()
    private let markAsPaidBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Mark As Paid", for: .normal)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 16
        btn.isHidden = true
        btn.addTarget(self, action: #selector(didTapMarkAsPaid), for: .touchUpInside)
        return btn
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
        
        contentView.addSubview(overdueView)
        contentView.addSubview(markAsPaidBtn)
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
      
        overdueView.frame = contentView.bounds
        markAsPaidBtn.sizeToFit()
        markAsPaidBtn.frame = CGRect(x: (width-markAsPaidBtn.width)/2, y: (height-markAsPaidBtn.height)/2, width: markAsPaidBtn.width+32, height: markAsPaidBtn.height)
    }
    

    func configure(with viewModel: SubscriptionViewCellViewModel) {
        subId = viewModel.subId
        nameLabel.text = viewModel.name
        dueInLb.text = viewModel.dueDate
        costLb.text = viewModel.cost
        logoImageView.image = UIImage(named: viewModel.logo)
        
        overdueView.isHidden = !viewModel.isOverDue
        markAsPaidBtn.isHidden = !viewModel.isOverDue
    }
    
    @objc func didTapMarkAsPaid(){
        if let id = subId{
            delegate?.markAsPaid(subId: id)
        }
    }

}
