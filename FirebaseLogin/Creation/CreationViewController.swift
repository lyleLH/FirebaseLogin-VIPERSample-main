//
//  CreationViewController.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation
protocol CreationViewProtocol: AnyObject {
    
}

class CreationViewController: UIViewController, CreationViewProtocol {

    var presenter: CreationPresenterProtocol?

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.title = "创建训练"
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

