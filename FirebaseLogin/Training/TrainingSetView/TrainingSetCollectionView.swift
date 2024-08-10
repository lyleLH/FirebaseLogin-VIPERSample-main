import UIKit
import SwipeCellKit

import Foundation

struct TrainingSet {
    var setNumber: Int
    var weight: Double
    var repetitions: Int
    var isCompleted: Bool
}

struct TrainingSection {
    var title: String
    var sets: [TrainingSet]
}

class TrainingSetCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TrainingSetCellDelegate, SectionFooterViewDelegate, SwipeCollectionViewCellDelegate {
    
    var sections: [TrainingSection] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        dataSource = self
        delegate = self
        alwaysBounceVertical = true
        contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 100, right: 0)
        register(UINib(nibName: "TrainingSetCell", bundle: nil), forCellWithReuseIdentifier: TrainingSetCell.reuseIdentifier)
        register(SectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionFooterView.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].sets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingSetCell.reuseIdentifier, for: indexPath) as! TrainingSetCell
        let set = sections[indexPath.section].sets[indexPath.item]
        cell.configure(with: set)
        cell.eventDelegate = self
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionFooterView.reuseIdentifier, for: indexPath) as! SectionFooterView
            footerView.section = indexPath.section
            footerView.delegate = self
            return footerView
        }
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32.0, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width  , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 8.0, right: 16)
    }
    
    // MARK: - TrainingSetCellDelegate
    
    func didTapCompleteButton(in cell: TrainingSetCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        sections[indexPath.section].sets[indexPath.item].isCompleted = true
        reloadItems(at: [indexPath])
    }
    
    // MARK: - SectionFooterViewDelegate
    
    func didTapAddButton(in section: Int) {
        let newSet = TrainingSet(setNumber: sections[section].sets.count + 1, weight: 0.0, repetitions: 0, isCompleted: false)
        sections[section].sets.append(newSet)
        let indexPath = IndexPath(item: sections[section].sets.count - 1, section: section)
        insertItems(at: [indexPath])
    }
    
    // MARK: - Swipe to delete
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.deleteSet(at: indexPath)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    func visibleRect(for collectionView: UICollectionView) -> CGRect? {
        return nil
    }
    
    
    private func deleteSet(at indexPath: IndexPath) {
        sections[indexPath.section].sets.remove(at: indexPath.item)
        deleteItems(at: [indexPath])
    }
}
