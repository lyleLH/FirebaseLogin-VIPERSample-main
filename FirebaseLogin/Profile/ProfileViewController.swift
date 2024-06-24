//
//  ProfileViewController.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation
protocol ProfileViewProtocol: AnyObject {
    
}

class ProfileViewController: UIViewController, ProfileViewProtocol {

    var presenter: ProfilePresenterProtocol?

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.title = "More"
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

