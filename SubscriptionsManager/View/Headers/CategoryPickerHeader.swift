//
//  CategoryPickerHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import UIKit


protocol CategoryPickerHeaderDelegate: AnyObject {
    func cancel()
}

class CategoryPickerHeader: UITableViewHeaderFooterView {
    
    public static let identifier = "CategoryPickerHeader"
    
    var delegate: CategoryPickerHeaderDelegate?
    
    private let titleLb: UILabel = {
       let lb = UILabel()
        lb.text = "Choose a category"
        lb.font = M.Fonts.modalTitle
        return lb
    }()
    private let cancelBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(systemName: "xmark", withConfiguration: .none)
        btn.setImage(img, for: .normal)
        btn.tintColor = .black
        return btn
    }()
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLb)
        addSubview(cancelBtn)
        
        cancelBtn.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.sizeToFit()
        titleLb.sizeToFit()
        
        let horizontalMargin = 16.0
        cancelBtn.frame = CGRect(x: horizontalMargin, y: (height-cancelBtn.height)/2, width: cancelBtn.width, height: cancelBtn.height)
        titleLb.frame = CGRect(x: (width-titleLb.width)/2, y: (height-titleLb.height)/2, width: titleLb.width, height: titleLb.height)
     
    }
    
    @objc func didTapCancel(){
        delegate?.cancel()
    }

}


