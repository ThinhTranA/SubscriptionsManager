//
//  CategoryCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 11/4/2022.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"
    
    let nameLb: UILabel = UILabel()
    let categoryImg: UIImageView = {
        let categoryImg = UIImageView()
        categoryImg.backgroundColor = .lightGray.withAlphaComponent(0.2)
        categoryImg.layer.cornerRadius = 16
        categoryImg.contentMode = .center
        return categoryImg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLb)
        addSubview(categoryImg)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        nameLb.sizeToFit()
        categoryImg.sizeToFit()
        
        categoryImg.frame = CGRect(x: 12, y: (height-32)/2, width: 32, height: 32)
        nameLb.frame = CGRect(x:categoryImg.right+16, y: (height-nameLb.height)/2, width: nameLb.width, height: nameLb.height)
    }
    
    override func prepareForReuse() {
        nameLb.text = nil
        categoryImg.image = nil
    }
    
    
    func configure(with category: CategoryRowViewModel){
        nameLb.text = category.category
        categoryImg.image = UIImage(
            systemName: category.categoryImg,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))
        categoryImg.tintColor = category.categoryImgColor
    }

}
