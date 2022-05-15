//
//  PaddingLabel.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 24/4/2022.
//

import Foundation
import UIKit
class MLabel: UILabel {
    
    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat
    
    required init(withInsets top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    func addTrailing(image: UIImage?, text:String) {
        let attachment = NSTextAttachment()
        if let image = image {
            attachment.image = image
        }

        let attachmentString = NSAttributedString(attachment: attachment)
        
        let trailingSpaceText = "\(text)  "
        let string = NSMutableAttributedString(string: trailingSpaceText, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
    
    func addLeading(image: UIImage?, text:String) {
        let attachment = NSTextAttachment()
        if let image = image {
            attachment.image = image
        }

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let leadingSpaceText = "  \(text)"
        let string = NSMutableAttributedString(string: leadingSpaceText, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
    
}
