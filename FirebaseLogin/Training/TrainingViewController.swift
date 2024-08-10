//
//  TrainingViewController.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation
protocol TrainingViewProtocol: AnyObject {
    
}

class TrainingViewController: MTViewController, TrainingViewProtocol {

    
    override var navigationBarBackgroundColor: UIColor {
        return .clear
    }
    
    override var navigationBarTintColor: UIColor {
        return .white
    }
    
    override var navigationViewBackgroundColor: UIColor {
        return .clear
    }
    
    override var navigationBarIsTranslucent: Bool {
        return true
    }
    override var navigationBarHidden: Bool {
        return true
    }
    
    var presenter: TrainingPresenterProtocol?

    var timerVc: TimerViewController?
    
    @IBOutlet weak var trainingGroupContainerView: UIView!
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var timerContainerView: UIView!
    
    var collectionView: TrainingSetCollectionView = {
        let collectionView = TrainingSetCollectionView()
        return collectionView
    } ()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        timerVc = TimerViewController()
        guard let timerVc = timerVc  else { return }
        timerVc.delegate = presenter
        view.backgroundColor = .white
        embedViewController(containerView: backgroundContainerView, controller: DarkCometViewController(), previous: nil)
        embedViewController(containerView: timerContainerView, controller: timerVc, previous: nil)
        trainingGroupContainerView.embedView(view: collectionView)
        // Mock data
        let section1 = TrainingSection(title: "Section 1", sets: [TrainingSet(setNumber: 1, weight: 20, repetitions: 10, isCompleted: false)])
        let section2 = TrainingSection(title: "Section 2", sets: [TrainingSet(setNumber: 1, weight: 25, repetitions: 12, isCompleted: false)])
        
        collectionView.sections = [section1, section2]
    }
}

