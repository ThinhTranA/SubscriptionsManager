//
//  BottomTabView.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 30/3/2022.
//

import UIKit

protocol BotomTabViewDelegate: AnyObject {
    func openSettings()
    func addSubscription()
    func sortBy(order: SortOrder)
}

class BottomTabView: UIView {
    static let tabHeight: CGFloat = {
        let bottomTabHeight = 50.0
        let safeAreaBottom = 20.0
        let bottomEdge = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.safeAreaInsets.bottom
        
        if bottomEdge ?? 0 > 0 {
            return bottomTabHeight + safeAreaBottom
        }
        return bottomTabHeight
    }()
    
    weak var delegate: BotomTabViewDelegate?

    private let settingImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "gear")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let sortBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
        btn.tintColor = .white
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        return btn
    }()
    
    private let addSubButton: UIButton = {
        let button = UIButton()
        let image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = M.Colors.primaryColor
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 8
        button.layer.masksToBounds = false
        return button
    }()
    

    
    override init(frame: CGRect){
        super.init(frame: frame)
        clipsToBounds = false
        backgroundColor = M.Colors.primaryColor
        layer.borderWidth = 0
        
        addSubViews()
        configureButtons()
    }
    
    private func addSubViews(){
        addSubview(settingImageView)
        addSubview(sortBtn)
        addSubview(addSubButton)
    }
    
    // Allow addSubButton which is outside of view bounds to be tapped.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //This might get called more than once when button tapped, this is normal
        //https://stackoverflow.com/questions/6550107/why-is-hittestwithevent-called-three-times-for-each-touch
        let translatedPoint = addSubButton.convert(point, from: self)
        
        if (addSubButton.bounds.contains(translatedPoint)) {
            return addSubButton.hitTest(translatedPoint, with: event)
        }
        return super.hitTest(point, with: event)
    }
    
    private func configureButtons(){
        let tapSettings = UITapGestureRecognizer(target: self, action: #selector(didTapSettings))
        settingImageView.isUserInteractionEnabled = true
        settingImageView.addGestureRecognizer(tapSettings)
        
        addSubButton.addTarget(self, action: #selector(didTapAddSubscription), for: .touchUpInside)

        sortBtn.showsMenuAsPrimaryAction = true
        sortBtn.menu = UIMenu(title: "", children: SortOrder.allValues.map { sortOrder in
            UIAction(title: sortOrder.description, image: sortOrder.icon, handler: { [weak self] _ in
                switch(sortOrder){
                case .AtoZ:
                    self?.delegate?.sortBy(order: .AtoZ)
                case .ZtoA:
                    self?.delegate?.sortBy(order: .ZtoA)
                case .PriceHighToLow:
                    self?.delegate?.sortBy(order: .PriceHighToLow)
                case .PriceLowToHigh:
                    self?.delegate?.sortBy(order: .PriceLowToHigh)
                }
            })
        })
        
    }
    
    @objc func didTapSettings(){
        delegate?.openSettings()
    }
    
    @objc func didTapAddSubscription(){
        delegate?.addSubscription()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tabHeight = BottomTabView.tabHeight
        
        let tabImageButtonSize = 40.0
        settingImageView.frame = CGRect(x:8, y: height - tabHeight + 4, width: tabImageButtonSize, height: tabImageButtonSize)
        
        let settingImageSize = 40.0
        sortBtn.frame = CGRect(x:width - tabImageButtonSize - 8, y: height - tabHeight + 4, width: settingImageSize, height: settingImageSize)
        
        let addSubButtonSize = 56.0
        addSubButton.frame = CGRect(x:(width-addSubButtonSize)/2, y: height - tabHeight - addSubButtonSize/2, width: addSubButtonSize, height: addSubButtonSize)
        
        drawCurve()
        bringSubviewToFront(addSubButton)
    }
  
}

extension BottomTabView {
    func drawCurve() {
        
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = createBezierPath().cgPath
        
        // apply other properties related to the path
        shapeLayer.strokeColor = UIColor.systemBackground.cgColor
        shapeLayer.fillColor = UIColor.systemBackground.cgColor
        shapeLayer.lineWidth = 0.0
        shapeLayer.position = CGPoint(x: width/2 - 40, y: 0)
        
        // add the new layer to our custom view
        self.layer.addSublayer(shapeLayer)
    }
    
    func createBezierPath() -> UIBezierPath {
     
        //// Bezier Drawing
              let bezierPath = UIBezierPath()
              bezierPath.move(to: CGPoint(x: 62, y: 25))
              bezierPath.addCurve(to: CGPoint(x: 40, y: 34), controlPoint1: CGPoint(x: 56, y: 31), controlPoint2: CGPoint(x: 47.65, y: 34))
              bezierPath.addCurve(to: CGPoint(x: 18, y: 25), controlPoint1: CGPoint(x: 33, y: 34), controlPoint2: CGPoint(x: 24, y: 31))
              bezierPath.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: 5.91, y: 12.91), controlPoint2: CGPoint(x: 8, y: 0))
              bezierPath.addLine(to: CGPoint(x: 80, y: 0))
              bezierPath.addCurve(to: CGPoint(x: 62, y: 25), controlPoint1: CGPoint(x: 72, y: 0), controlPoint2: CGPoint(x: 72.54, y: 14.46))
              bezierPath.close()
        
        
          //  path.close()
            return bezierPath
        
    }

}
