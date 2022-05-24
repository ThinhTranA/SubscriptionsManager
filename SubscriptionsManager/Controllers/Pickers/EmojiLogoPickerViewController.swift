//
//  CustomizeViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 21/5/2022.
//

import UIKit

protocol EmojiLogoPickerDelegate: AnyObject {
    func saveCustomizeIcon(emoji: String)
}

class EmojiLogoPickerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let emojiCellSize = 42.0
    var emojisList: [Emojis] = []
    var delegate: EmojiLogoPickerDelegate?
    
    init(){
        super.init(collectionViewLayout: EmojiLogoPickerViewController.createLayout())
        collectionView.register(EmojiViewCell.self, forCellWithReuseIdentifier: EmojiViewCell.identifier)
        collectionView.register(EmojiHeaderView.self, forSupplementaryViewOfKind: EmojiHeaderView.categoryHeaderId, withReuseIdentifier: EmojiHeaderView.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://unicode.org/Public/emoji/15.0/emoji-sequences.txt
        emojisList.append(Emojis(category: "People", list: Emojis.toList(range: 0x1F601...0x1F64F)))
        emojisList.append(Emojis(category: "Animal", list: Emojis.toList(range: 0x1F401...0x1F43F)))
        emojisList.append(Emojis(category: "Transport", list: Emojis.toList(range: 0x1F680...0x1F6AF)))
        emojisList.append(Emojis(category: "Symbols", list: Emojis.toList(range: 0x1F701...0x1F74F)))
        emojisList.append(Emojis(category: "Nature", list: Emojis.toList(range: 0x1F301...0x1F353)))
        emojisList.append(Emojis(category: "Random", list: Emojis.toList(range: 0x1F90C...0x1F9FF)))
        
        configureNavigationBar()
    }
    
    
    private func configureNavigationBar(){
        title = "Select a custom icon"
        let doneBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 24))
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.titleLabel?.font = .systemFont(ofSize: 14)
        doneBtn.layer.cornerRadius = 14
        doneBtn.clipsToBounds = true
        doneBtn.backgroundColor = M.Colors.primaryColor
        doneBtn.addTarget(self, action: #selector(didTapDoneBtn), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
        let closeBtn = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(didTapCloseBtn))
        closeBtn.tintColor = .label
        navigationItem.leftBarButtonItem = closeBtn
    }
    
    @objc func didTapCloseBtn(){
        dismiss(animated: true)
    }
    
    @objc func didTapDoneBtn(){
        dismiss(animated: true)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoji = emojisList[indexPath.section].list[indexPath.row]
        delegate?.saveCustomizeIcon(emoji: emoji)
        dismiss(animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        emojisList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojisList[section].list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiViewCell.identifier, for: indexPath) as? EmojiViewCell{
            emojiCell.configure(with: emojisList[indexPath.section].list[indexPath.row], size: emojiCellSize)
            return emojiCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: emojiCellSize, height: emojiCellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.identifier, for: indexPath) as? EmojiHeaderView {
            header.setTitle(title: emojisList[indexPath.section].category)
            return header
        }
        return EmojiHeaderView()
    }
    

    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/8), heightDimension: .absolute(48)))
            item.contentInsets.trailing = 0
            item.contentInsets.bottom = 0
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 0
            section.contentInsets.trailing = 0
            
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: EmojiHeaderView.categoryHeaderId, alignment: .topLeading)
            ]
            return section
        }
    }
}

class EmojiViewCell: UICollectionViewCell {
    static let identifier = "EmojiViewCell"
    
    private let emojiLb: UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emojiLb)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emojiLb.frame = contentView.bounds
    }
    
    func configure(with label: String, size: CGFloat){
        emojiLb.text = label
        emojiLb.font = .systemFont(ofSize: size)
    }
}


class EmojiHeaderView: UICollectionReusableView {
    static let identifier = "EmojiHeaderView"
    static let categoryHeaderId = "categoryHeaderId"
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = .systemFont(ofSize: 20, weight: .semibold)

        addSubview(label)
        backgroundColor = .secondarySystemBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds.insetBy(dx: 16, dy:0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String){
        label.text = title
    }
}






import SwiftUI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: EmojiLogoPickerViewController())
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
        
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
