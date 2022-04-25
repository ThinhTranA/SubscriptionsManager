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
    
    let validationMessageLb: UILabel = {
        let lb = MLabel(withInsets: 2, 2, 16, 16)
        lb.addLeading(
            image: UIImage(systemName: "info.circle")!.withTintColor(.white),
            text: "You need to add a price")
        lb.textColor = .white
        lb.backgroundColor = .darkGray
        lb.layer.cornerRadius = 16
        lb.layer.masksToBounds = true
        lb.isHidden = true
        return lb
    }()
    
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
        addSubview(validationMessageLb)
        addSubview(logoImg)
        addSubview(costTxtField)
        addSubview(currencyUnitLb)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        costTxtField.sizeToFit()
        currencyUnitLb.sizeToFit()
        
        if validationMessageLb.isHidden {
            validationMessageLb.frame = CGRect(x: 0, y: 0, width: 0, height: 0 )
        } else {
            validationMessageLb.sizeToFit()
            validationMessageLb.frame = CGRect(x: (width-validationMessageLb.width-32)/2, y: 24, width: validationMessageLb.width+32, height: 48)
        }
        
        let logoImgWidth = 100.0
        let logoImgHeight = 100.0
        logoImg.frame = CGRect(x: (width-logoImgWidth)/2, y: validationMessageLb.bottom+24, width: logoImgWidth, height: logoImgHeight)
        
        costTxtField.delegate = self
        costTxtField.frame = CGRect(x: (width-costTxtField.width-currencyUnitLb.width)/2, y: logoImg.bottom+16, width: costTxtField.width, height: costTxtField.height)
    
        currencyUnitLb.frame = CGRect(x: costTxtField.right, y: logoImg.bottom+16, width: currencyUnitLb.width, height: currencyUnitLb.height)
        
        if(costTxtField.text?.isEmpty ?? true &&
           validationMessageLb.isHidden) {
            costTxtField.becomeFirstResponder()
        }
            
      
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        costTxtField.sizeToFit()
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        validationMessageLb.isHidden = true
        setNeedsLayout()
        return true
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

