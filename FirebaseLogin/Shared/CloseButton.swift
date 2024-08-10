//
//  CloseButton.swift
//  FashionCamera
//
//  Created by Li Kedan on 6/27/22.
//  Copyright © 2022 KedanLi. All rights reserved.
//

import UIKit

class CloseButton: DefaultButton {
	
	override func commonInit() {
		super.commonInit()
		
		setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.medium, scale: .medium))?.withTintColor(UIColor.lightGrey), for: .normal)
	}
    
    func updateIconColor(color: UIColor) {
        setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.medium, scale: .medium))?.withTintColor(color), for: .normal)
    }

}
