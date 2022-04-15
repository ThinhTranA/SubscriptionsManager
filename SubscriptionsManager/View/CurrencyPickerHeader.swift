//
//  CurrencyPickerHeader.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 15/4/2022.
//

import UIKit

protocol CurrencyPickerHeaderDelegate: AnyObject {
    func cancel()
    func filterCurrency(with word: String)
}

class CurrencyPickerHeader: UITableViewHeaderFooterView, UISearchBarDelegate {
    
    public static let identifier = "CurrencyPickerHeader"
    
    var delegate: CurrencyPickerHeaderDelegate?

    private let titleLb: UILabel = {
       let lb = UILabel()
        lb.text = "Select a currency"
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
    private let searchBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(systemName: "magnifyingglass", withConfiguration: .none)
        btn.setImage(img, for: .normal)
        btn.tintColor = .black
        return btn
    }()
    private let doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.green, for: .normal)
        btn.setTitle("Done", for: .normal)
        btn.isHidden = true
        return btn
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isHidden = true
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search currency..."
        return searchBar
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLb)
        addSubview(cancelBtn)
        addSubview(searchBtn)
        
        addSubview(doneBtn)
        addSubview(searchBar)
        
        cancelBtn.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        searchBtn.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        doneBtn.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        searchBar.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.sizeToFit()
        titleLb.sizeToFit()
        searchBtn.sizeToFit()
        doneBtn.sizeToFit()
        searchBar.sizeToFit()
        
        let horizontalMargin = 8.0
        cancelBtn.frame = CGRect(x: horizontalMargin, y: (height-cancelBtn.height)/2, width: cancelBtn.width, height: cancelBtn.height)
        titleLb.frame = CGRect(x: (width-titleLb.width)/2, y: (height-titleLb.height)/2, width: titleLb.width, height: titleLb.height)
        searchBtn.frame = CGRect(x: width-searchBtn.width-horizontalMargin, y: (height-searchBtn.height)/2, width: searchBtn.width, height: searchBtn.height)
        
        doneBtn.frame = CGRect(x: width-doneBtn.width-horizontalMargin, y: (height-doneBtn.height)/2, width: doneBtn.width, height: doneBtn.height)
        
        searchBar.frame = CGRect(x: horizontalMargin, y: (height-searchBar.height)/2, width: width-doneBtn.width-horizontalMargin*2, height: searchBar.height)
    }
    
    @objc func didTapCancel(){
        delegate?.cancel()
    }
    
    @objc func didTapSearch(){
        cancelBtn.isHidden = true
        searchBtn.isHidden = true
        titleLb.isHidden = true
        
        doneBtn.isHidden = false
        searchBar.isHidden = false
    }
    
    @objc func didTapDone(){
        cancelBtn.isHidden = false
        searchBtn.isHidden = false
        titleLb.isHidden = false
        
        doneBtn.isHidden = true
        searchBar.isHidden = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.filterCurrency(with: searchText)
    }
    


}


