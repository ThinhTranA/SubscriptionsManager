//
//  AddUpdateSubHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 16/4/2022.
//

import UIKit

protocol AddUpdateSubHeaderDelegate: AnyObject {
    func displayWithPrice(price: Decimal, currency: Currency)
}

class AddUpdateSubHeader: UIView, UITextFieldDelegate {
    var delegate: AddUpdateSubHeaderDelegate?
    
    var price: Decimal?
    
    let logoImg: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let costTxtField: UITextField = {
        let txtField = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 48))
        txtField.textColor = M.Colors.white
        txtField.placeholder = "0.00"
        txtField.font = .systemFont(ofSize: 32, weight: .semibold)
        txtField.textAlignment = .center
        txtField.keyboardType = .numberPad
        let viewForDoneButtonOnKeyboard = UIToolbar()
        viewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnFromKeyboardClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        viewForDoneButtonOnKeyboard.items = [flexibleSpace,btnDoneOnKeyboard]
    
        
        txtField.inputAccessoryView = viewForDoneButtonOnKeyboard
        return txtField
    }()
    
    @objc func doneBtnFromKeyboardClicked(){
        costTxtField.resignFirstResponder()
        costTxtField.sizeToFit()
    }
    
    let currencyUnitLb: UILabel = {
        let lb = UILabel()
        lb.text = "$"
        lb.font = .systemFont(ofSize: 32, weight: .semibold)
        lb.textColor = M.Colors.white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(logoImg)
        addSubview(costTxtField)
        addSubview(currencyUnitLb)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let logoImgWidth = 100.0
        let logoImgHeight = 100.0
        logoImg.frame = CGRect(x: (width-logoImgWidth)/2, y: (height-logoImgHeight)/2-24, width: logoImgWidth, height: logoImgHeight)
        
        costTxtField.sizeToFit()
        currencyUnitLb.sizeToFit()
        costTxtField.delegate = self
        costTxtField.frame = CGRect(x: (width-costTxtField.width-currencyUnitLb.width)/2, y: logoImg.bottom+16, width: costTxtField.width, height: costTxtField.height)
    
        currencyUnitLb.frame = CGRect(x: costTxtField.right, y: logoImg.bottom+16, width: currencyUnitLb.width, height: currencyUnitLb.height)
        
        costTxtField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        costTxtField.sizeToFit()
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    func configure(with sub: Subscription){
        if let currency = sub.currency {
            currencyUnitLb.text = currency.symbol
        }
         else {
            currencyUnitLb.text = "$"
        }
        
        if sub.price > 0 {
            costTxtField.text = "\(sub.price)"
        } else {
            costTxtField.placeholder = "0.00"
        }
        
        backgroundColor = sub.color
        if let imgName = sub.logo {
            logoImg.image = UIImage(named: imgName)
        }
    }
}
