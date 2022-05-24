//
//  FormPickerInputAccessoryView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 10/4/2022.
//

import UIKit

protocol FormPickerInputAccessoryViewDelegate: AnyObject {
    func didTapCancel()
    func didTapDone()
}

class FormPickerInputAccessoryView: UIView {
    private let label : UILabel = UILabel()
    private let cancelBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    private let doneBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
    
    weak var delegate: FormPickerInputAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let cancelImage = UIImage(systemName: "multiply")
        cancelBtn.setImage(cancelImage, for: .normal)
        cancelBtn.tintColor = .black
        cancelBtn.layer.cornerRadius = 16
        cancelBtn.backgroundColor = .clear
        cancelBtn.frame = CGRect(x: 8, y: (height-cancelBtn.height)/2, width: cancelBtn.width, height: cancelBtn.height)
        cancelBtn.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)

        label.sizeToFit()
        label.frame = CGRect(x: (width-label.width)/2, y: (height-label.height)/2, width: label.width, height: label.height)

        doneBtn.setTitle("Done", for: .normal)
        doneBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        doneBtn.backgroundColor = M.Colors.primaryColor
        doneBtn.layer.cornerRadius = 12
        doneBtn.frame = CGRect(x: width-doneBtn.width-8, y: (height-doneBtn.height)/2, width: doneBtn.width, height: doneBtn.height)
        doneBtn.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)

        addSubview(cancelBtn)
        addSubview(label)
        addSubview(doneBtn)
    }
    
    func configure(withTitle title: String){
        label.text = title
    }
    
    @objc func didTapCancel(){
        delegate?.didTapCancel()
    }
    
    @objc func didTapDone() {
        delegate?.didTapDone()
    }
    
}
