//
//  TransparentDefaultViewController.swift
//  FashionCamera
//
//  Created by Tom.Liu on 2024/9/20.
//

import UIKit

class TransparentDefaultViewController: DefaultViewController {
    
    
    override var navigationBarBackgroundColor: UIColor {
        .clear
    }
    
    override var navigationBarIsTranslucent: Bool {
        true
    }
    
    override var navigationBarTintColor: UIColor {
        .white
    }
    
    override var navigationViewBackgroundColor: UIColor {
        .clear
    }
    
    override var isBackButtonHasBackground: Bool {
        true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = .clear
        }
    }
    

}
