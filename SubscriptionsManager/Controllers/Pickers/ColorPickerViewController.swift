import UIKit

protocol ColorPickerDelegate: AnyObject {
    func saveColor(colorHex: String)
}

class ColorPickerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellSize = 42.0
    var delegate: ColorPickerDelegate?
    var colorList: [String] = []
    
    init(){
        super.init(collectionViewLayout: ColorPickerViewController.createLayout())
        collectionView.register(ColorViewCell.self, forCellWithReuseIdentifier: ColorViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //https://coolors.co/312f2f-84dccf-a6d9f7-bccce0-bf98a0
        colorList = ["#2AA868","#004F2D","#091E05","#D87CAC","#F9B9C3","#FFDA22","#222222","#1C5D99"
                     ,"#639FAB","#BBCDE5","#312F2F","#84DCCF","#A6D9F7","#BCCCE0","#BF98A0","#533747",
                     "#5F506B","#6A6B83","#BEB7A4","#86BBBD","#E4B7E5","#B288C0","#7E5A9B","#E6AF2E",
                     "#9A48D0","#2589BD","#187795","#38686A"]
        
        configureNavigationBar()
    }
    
    
    private func configureNavigationBar(){
        title = "Select a color"
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
        let color = colorList[indexPath.row]
        delegate?.saveColor(colorHex: color)
        dismiss(animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorViewCell.identifier, for: indexPath) as? ColorViewCell{
            colorCell.configure(with: colorList[indexPath.row], size: cellSize)
            return colorCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    

    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1/10)))
            item.contentInsets.trailing = 0
            item.contentInsets.bottom = 0
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 0
            section.contentInsets.trailing = 0
         
            return section
        }
    }
}

class ColorViewCell: UICollectionViewCell {
    static let identifier = "ColorViewCell"
    
    let colorView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(colorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.frame = CGRect(x: (width-64)/2, y: (height-64)/2, width: 64, height: 64)
    }
    
    func configure(with colorHex: String, size: CGFloat){
        colorView.layer.cornerRadius = 32
        colorView.backgroundColor = UIColor(hexaString: colorHex)
    }
}



import SwiftUI
struct ColorPickerContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: ColorPickerViewController())
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
        
    }
}

struct ColorPickerContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
