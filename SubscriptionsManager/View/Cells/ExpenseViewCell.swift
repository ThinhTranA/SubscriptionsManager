//
//  ExpenseViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 19/4/2022.
//

import UIKit

class ExpenseViewCell: UITableViewCell {
    
    static let identifier = "ExpenseViewCell"

    private let logoImg: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 8
        return imgView
    }()
    
    private let nameLb: UILabel = {
        let nameLb = UILabel()
        return nameLb
    }()
    
    private let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("ADD", for: .normal)
        btn.setTitleColor(UIColor.green.darker(by: 20), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .gray.withAlphaComponent(0.3)
        btn.tintColor = .green
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImg)
        addSubview(nameLb)
        addSubview(addBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImg.frame = CGRect(x: 12, y: (height-36)/2, width: 36, height: 36)
        nameLb.sizeToFit()
        nameLb.frame = CGRect(x: logoImg.right+16, y: (height-nameLb.height)/2, width: nameLb.width, height: nameLb.height)
        
        addBtn.sizeToFit()
        addBtn.frame = CGRect(x: width-48-8, y: (height-20)/2, width: 48, height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImg.image = nil
        nameLb.text = nil
    }
    
    func configure(with expense: Expense){
        logoImg.image = UIImage(named: expense.logo)
        
        nameLb.text = expense.name
    }
}
