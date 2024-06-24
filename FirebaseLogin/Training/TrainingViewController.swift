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

class TrainingViewController: UIViewController, TrainingViewProtocol {

    var presenter: TrainingPresenterProtocol?

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
        view.backgroundColor = .white

    }
}

