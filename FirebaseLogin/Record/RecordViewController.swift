//
//  RecordViewController.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation
protocol RecordViewProtocol: AnyObject {
    
}

class RecordViewController: UIViewController, RecordViewProtocol {

    var presenter: RecordPresenterProtocol?

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.title = "训练记录"
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
        embedViewController(containerView: view, controller: PeaceCometsViewController(), previous: nil)

    }
}

