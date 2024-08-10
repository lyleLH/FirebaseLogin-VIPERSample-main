//
//  WorkoutSectionCell.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/24.
//

import UIKit


class WorkoutSectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var sectionIndex: Int = 0
    weak var delegate: WorkoutActionSelectionDelegate?
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var actionPositionLabel: UILabel!
    private var groups: [WorkoutGroup] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInint()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInint()
    }
    
    
    func commonInint() {
        collectionView.dataSource = self
        collectionView.delegate = self
        backgroundColor = .clear
        collectionView.register(UINib(nibName: "WorkoutGroupCell", bundle: nil), forCellWithReuseIdentifier: "kWorkoutGroupCell")
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.embedView(view: collectionView)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    
    func configure(with section: WorkoutSection, sectionIndex: Int) {
        self.sectionIndex = sectionIndex
        self.groups = section.groups
        self.actionPositionLabel.text = section.title
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kWorkoutGroupCell", for: indexPath) as! WorkoutGroupCell
        cell.configure(with: groups[indexPath.item], in: sectionIndex)
        cell.delegate = self.delegate
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width - 32, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

extension UICollectionViewCell {
    
    func addCellShadowEffect(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.dark.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.25
        layer.masksToBounds = true
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
