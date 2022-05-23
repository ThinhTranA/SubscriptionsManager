//
//  CustomizeViewController.swift
//  SubscriptionsManager
//
//  Created by Thinh Tran on 21/5/2022.
//

import UIKit

class CustomizeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let emojiCellSize = 42.0
    var emojisList: [Emojis] = []
    
    init(){
        super.init(collectionViewLayout: CustomizeViewController.createLayout())
        collectionView.register(EmojiViewCell.self, forCellWithReuseIdentifier: EmojiViewCell.identifier)
        collectionView.register(EmojiHeaderView.self, forSupplementaryViewOfKind: EmojiHeaderView.categoryHeaderId, withReuseIdentifier: EmojiHeaderView.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    //https://stackoverflow.com/questions/26170876/how-to-list-almost-all-emojis-in-swift-for-ios-8-without-using-any-form-of-loo
        //https://unicode.org/Public/emoji/15.0/emoji-sequences.txt
        // NOTE: These ranges are still just a subset of all the emoji characters;
        //       they seem to be all over the place...
        //https://www.unicode.org/emoji/charts/full-emoji-list.html
        
        emojisList.append(Emojis(category: "People", list: Emojis.toList(range: 0x1F601...0x1F64F)))
        emojisList.append(Emojis(category: "Animal", list: Emojis.toList(range: 0x2702...0x27B0)))
        emojisList.append(Emojis(category: "Nature", list: Emojis.toList(range: 0x1F680...0x1F6C0)))
        emojisList.append(Emojis(category: "City", list: Emojis.toList(range: 0x1F170...0x1F251)))
        
        print(emojisList)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(emojisList[indexPath.section].list[indexPath.row])
        //print(emojiDataSource[indexPath.row])
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
            print(indexPath.section)
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
            section.contentInsets.leading = 12
            section.contentInsets.trailing = 12
            
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
        label.text = "Categories"
        addSubview(label)
        backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
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
            UINavigationController(rootViewController: CustomizeViewController())
            
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
