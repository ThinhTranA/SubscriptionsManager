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
        label.textColor = .init(white: 1, alpha: 0.9)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .init(white: 1, alpha: 0.9)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
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
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        
        label.sizeToFit()
        label.frame = CGRect(x: 24, y: 0, width: label.width, height: contentView.height)
        
        textField.sizeToFit()
        let textFieldWidth = 180.0
        textField.frame = CGRect(x: width-textFieldWidth-24, y: 0, width: textFieldWidth, height: 40)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.becomeFirstResponder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        textField.text = nil
    }
    
    func configure(with viewModel: EntryTableViewCellViewModel){
        label.text = viewModel.name
        textField.attributedPlaceholder = NSAttributedString(string: viewModel.name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 0.3, alpha: 0.7)])
    }
    

}
