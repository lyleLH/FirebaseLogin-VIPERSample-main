//
//  WorkoutGroupCell.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/24.
//

import UIKit



class WorkoutGroupCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: WorkoutGroupCellDelegate?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    private var group:  WorkoutGroup?
    private var actions: [WorkoutAction] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView?.embedView(view: collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCellShadowEffect(cornerRadius: 8)
        
    }
    
    func commonInit() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "WorkoutActionCell", bundle: nil), forCellWithReuseIdentifier: "kWorkoutActionCell")
    }
    
    
    func configure(with group: WorkoutGroup) {
        self.group = group
        self.actions = group.actions
        typeLabel.text = group.equipmentType
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kWorkoutActionCell", for: indexPath) as! WorkoutActionCell
        cell.configure(with: actions[indexPath.item])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let group = group, let cell = collectionView.cellForItem(at: indexPath) {
            delegate?.didSelectedAction(action: actions[indexPath.item], group: group, cell: cell)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
}
