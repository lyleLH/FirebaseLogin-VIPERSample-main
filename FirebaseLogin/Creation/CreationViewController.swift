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
        // Mock data
        let dumbbellActions = [WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                                                      WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                                                      WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                                                      WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell")]
        
        let barbellActions = [WorkoutAction(name: "Barbell Squat", equipmentType: "Barbell"),
                              WorkoutAction(name: "Barbell Deadlift", equipmentType: "Barbell")]
        
        let cableActions = [WorkoutAction(name: "Cable Crossover", equipmentType: "Cable"),
                            WorkoutAction(name: "Cable Row", equipmentType: "Cable")]
        
        let machineActions = [WorkoutAction(name: "Leg Press", equipmentType: "Machine"),
                              WorkoutAction(name: "Chest Press", equipmentType: "Machine")]
        
        let chestGroup = [WorkoutGroup(equipmentType: "Dumbbell", actions: dumbbellActions),
                          WorkoutGroup(equipmentType: "Barbell", actions: barbellActions)]
        
        let backGroup = [WorkoutGroup(equipmentType: "Cable", actions: cableActions),
                         WorkoutGroup(equipmentType: "Machine", actions: machineActions)]
        
        let sections = [WorkoutSection(title: "Chest", groups: chestGroup),
                        WorkoutSection(title: "Back", groups: backGroup),
                        WorkoutSection(title: "Chest", groups: chestGroup),
                        WorkoutSection(title: "Chest", groups: chestGroup),
        ]
        
        collectionView.sections = sections
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        embedViewController(containerView: backgroundContainerView, controller: cometsVc, previous: nil)
    }
    
    func didSelectedAction(action: WorkoutAction, group: WorkoutGroup, cell: UICollectionViewCell) {
         
    }
    
}

