import UIKit

protocol ColorPickerDelegate: AnyObject {
    func saveColor(color: UIColor)
}

class ColorPickerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellSize = 42.0
    var delegate: ColorPickerDelegate?
    var colorList: [UIColor] = []
    
    init(){
        super.init(collectionViewLayout: ColorPickerViewController.createLayout())
        collectionView.register(ColorViewCell.self, forCellWithReuseIdentifier: ColorViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorList.append(UIColor(hexaString: "#2AA868"))
        colorList.append(UIColor(hexaString: "#31F592"))
        
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
        doneBtn.backgroundColor = .green
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
        delegate?.saveColor(color: color)
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
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/4), heightDimension: .absolute(48)))
            item.contentInsets.trailing = 8
            item.contentInsets.bottom = 8
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 8
            section.contentInsets.trailing = 8
         
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
        colorView.frame = contentView.bounds
    }
    
    func configure(with color: UIColor, size: CGFloat){
        colorView.layer.cornerRadius = self.frame.width/2
        colorView.backgroundColor = color
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
