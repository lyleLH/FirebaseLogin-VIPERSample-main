//
//  CanvasViewController.swift
//  
//
//  Created by Tom.Liu on .
//
//

import UIKit
import AVFoundation
import Combine

protocol CanvasViewProtocol: AnyObject {
    
}

class CanvasViewController: UIViewController, CanvasViewProtocol {

    var presenter: CanvasPresenterProtocol?
    
    var canvasContainerView: UIView = {
        let canvasContainerView = UIView()
        canvasContainerView.translatesAutoresizingMaskIntoConstraints = false
        canvasContainerView.backgroundColor = .clear
        return canvasContainerView
    }()

    
    var canvasView: CanvasView = CanvasView(frame: .zero)
    
 
    
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
        view.embedView(view: canvasContainerView)
        let itemViews = CanvasView.testItems()
        canvasView.configItemViews(itemViews: itemViews)
        canvasContainerView.embedView(view: canvasView)
        canvasView.relayoutItemVies()
    }
    
    @objc private func handleSignInButton() {
        presenter?.notifySignInTapped()
    }
    
    @objc private func handleSignUpButton() {
        presenter?.notifySignUpTapped()
    }
    
   
  
}

