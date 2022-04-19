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
        nameLb.font = .systemFont(ofSize: 18, weight: .semibold)
        return nameLb
    }()
    
    private let catLb: UILabel = {
        let catLb = UILabel()
        catLb.font = .systemFont(ofSize: 14)
        catLb.textColor = .gray
        return catLb
    }()
    
    private let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("ADD", for: .normal)
        btn.setTitleColor(UIColor.green.darker(by: 20), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .gray.withAlphaComponent(0.2)
        btn.tintColor = .green
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImg)
        addSubview(nameLb)
        addSubview(catLb)
        addSubview(addBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let horizontalInset = 12.0
        logoImg.frame = CGRect(x: horizontalInset, y: (height-42)/2, width: 42, height: 42)
        nameLb.sizeToFit()
        catLb.sizeToFit()
        nameLb.frame = CGRect(x: logoImg.right+16, y: (height-nameLb.height-catLb.height)/2, width: nameLb.width, height: nameLb.height)
        catLb.frame = CGRect(x: logoImg.right+16, y: nameLb.bottom, width: catLb.width, height: catLb.height)
        
        addBtn.sizeToFit()
        addBtn.frame = CGRect(x: width-48-horizontalInset, y: (height-20)/2, width: 48, height: 22)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImg.image = nil
        nameLb.text = nil
    }
    
    func configure(with expense: Expense){
        logoImg.image = UIImage(named: expense.logo)
        nameLb.text = expense.name
        catLb.text = expense.category
    }
}
