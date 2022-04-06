//
//  SubscriptionHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 6/4/2022.
//

import UIKit

class SubscriptionHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    private let cancelBtn: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "chevron.down")!
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let saveBtn: UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "gear")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Tesla"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(imageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: (width - nameLabel.width)/2, y: nameLabel.height, width: nameLabel.width, height: nameLabel.height)
        cancelBtn.frame = CGRect(x: 8, y: cancelBtn.height, width: cancelBtn.width, height: cancelBtn.height)
        saveBtn.frame = CGRect(x: width-saveBtn.width-8, y: saveBtn.height, width: saveBtn.width, height: saveBtn.height)
        
        imageView.frame = CGRect(x: (width-imageView.width)/2, y: nameLabel.bottom, width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: SubscriptionHeaderViewModel){
        nameLabel.text = viewModel.name
        //
    }

}
