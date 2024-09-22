//
//  DarkCometViewController.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/27.
//

import UIKit
import Gradients

class DarkCometViewController: CometsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundLayer = Gradients.softCherish.layer
        backgroundLayer.frame = view.bounds
        view.layer.addSublayer(backgroundLayer)
        
        // Do any additional setup after loading the view.
    }
    
}
