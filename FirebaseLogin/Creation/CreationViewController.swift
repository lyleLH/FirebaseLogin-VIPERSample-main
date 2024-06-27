//
//  CreationViewController.swift
//
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation


struct WorkoutAction {
    var name: String
    var equipmentType: String // 器械类型：哑铃、杠铃、绳索、固定器械
}

struct WorkoutGroup {
    var equipmentType: String
    var actions: [WorkoutAction]
}

struct WorkoutSection {
    var title: String
    var groups: [WorkoutGroup]
}



protocol CreationViewProtocol: AnyObject {
    func updateSectionViewData(sections: [WorkoutSection])
    func reloadSectionView(indexPath: IndexPath)
}

class CreationViewController: MTViewController, CreationViewProtocol, WorkoutGroupCellDelegate, WorkoutSectionCellDelegate, WorkoutSelectionCollectionViewDelegate {
 


    let cometsVc = CometsViewController()
    
    override var navigationBarIsTranslucent: Bool {
        return true
    }
    
    override var navigationBarBackgroundColor: UIColor {
        return .clear
    }
    
    override var navigationBarTintColor: UIColor {
        return .white
    }
    
    override var navigationViewBackgroundColor: UIColor {
        return .clear
    }
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: CreationPresenterProtocol?
    
    lazy var collectionView: WorkoutSelectionCollectionView = {
        let list = WorkoutSelectionCollectionView()
        return list
    }()
    
    
    private var groups: [WorkoutGroup] = []
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.title = "创建训练"
        collectionView.workoutSelectionViewDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK: - View Configurations
    private func configureUI() {
        view.backgroundColor = .white
       
        containerView.embedView(view: collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 200, right: 0)

        presenter?.notifyViewDidLoad()
        
    }
    
    func updateSectionViewData(sections: [WorkoutSection]) {
       
        collectionView.sections = sections
    }
    
    func reloadSectionView(indexPath: IndexPath) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.collectionView.reloadSections(IndexSet(integer: indexPath.section))
            }
        }
    }
    
    func isActionCellSelected(action: WorkoutAction) -> Bool {
        return presenter?.notifyCheckActionSelectionStatus(action: action) == true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        embedViewController(containerView: backgroundContainerView, controller: cometsVc, previous: nil)
    }
    
    
    func didSelectedAction(action: WorkoutAction, group: WorkoutGroup, in Section: Int) {
        let section = collectionView.sections[Section]
        presenter?.notifyDidClicked(action: action, group: group, section: section)

    }
 
    
}

