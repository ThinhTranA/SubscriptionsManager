//
//  AddUpdateSubHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 16/4/2022.
//

import UIKit

class AddUpdateSubHeader: UIView, UITextFieldDelegate {
    
    let logoImg: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "xmark", withConfiguration: .none)
        imgView.tintColor = .orange
        return imgView
    }()
    
    let costTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "0,00 USD"
        txtField.backgroundColor = .orange
        txtField.font = .systemFont(ofSize: 32, weight: .semibold)
        txtField.textAlignment = .center
        txtField.keyboardType = .numberPad
        return txtField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        clipsToBounds = true
        addSubview(logoImg)
        addSubview(costTxtField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let logoImgWidth = 80.0
        let logoImgHeight = 80.0
        logoImg.frame = CGRect(x: (width-logoImgWidth)/2, y: (height-logoImgHeight)/2-24, width: logoImgWidth, height: logoImgHeight)
        
        costTxtField.sizeToFit()
        costTxtField.delegate = self
        costTxtField.frame = CGRect(x: (width-128)/2, y: logoImg.bottom+16, width: 128, height: 48)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
}
