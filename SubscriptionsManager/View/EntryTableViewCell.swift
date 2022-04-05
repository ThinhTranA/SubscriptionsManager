//
//  EntryTableViewCell.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 5/4/2022.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    static let identifier = "EntryTableViewCell"

    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        contentView.addSubview(label)
        contentView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 0, width: label.width, height: contentView.height)
        
        textField.sizeToFit()
        let textFieldWidth = 180.0
        textField.frame = CGRect(x: width-textFieldWidth-16, y: 0, width: textFieldWidth, height: 40)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        textField.text = nil
    }
    
    func configure(with viewModel: EntryTableViewCellViewModel){
        label.text = viewModel.name
        textField.placeholder = viewModel.name
    }
    

}
