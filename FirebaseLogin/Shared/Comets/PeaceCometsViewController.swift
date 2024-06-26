//
//  PeaceCometsViewController.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/26.
//

import UIKit
import Gradients

class PeaceCometsViewController: CometsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundLayer = Gradients.elegance.layer
        backgroundLayer.frame = view.bounds
        view.layer.addSublayer(backgroundLayer)

        // Do any additional setup after loading the view.
    }
    


}
