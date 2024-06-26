//
//  WorkoutSelectionView.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/24.
//

import UIKit


typealias WorkoutActionSelectionDelegate = WorkoutSelectionCollectionViewDelegate & WorkoutSectionCellDelegate & WorkoutGroupCellDelegate

protocol WorkoutGroupCellDelegate: AnyObject {
        
    func didSelectedAction(action: WorkoutAction, group: WorkoutGroup, cell: UICollectionViewCell)
}


protocol WorkoutSectionCellDelegate: AnyObject {
        
}


protocol WorkoutSelectionCollectionViewDelegate: AnyObject {
    
}

class WorkoutSelectionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    weak var workoutSelectionViewDelegate: WorkoutActionSelectionDelegate?
    
    var sections: [WorkoutSection] = [] {
        didSet {
            reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        dataSource = self
        delegate = self
        showsVerticalScrollIndicator = false
        
        register(UINib(nibName: "WorkoutSectionCell", bundle: nil), forCellWithReuseIdentifier: "kWorkoutSectionCell")
        
//        register(WorkoutSectionCell.self, forCellWithReuseIdentifier: "WorkoutSectionCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kWorkoutSectionCell", for: indexPath) as! WorkoutSectionCell
        let section = sections[indexPath.section]
        cell.configure(with: section)
        cell.delegate = self.workoutSelectionViewDelegate
        return cell
    }
    

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 200 + 38)  
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 8.0, right: 16)
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 48.0
//    }
//    
//  
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        48.0
//    }
//    
}
