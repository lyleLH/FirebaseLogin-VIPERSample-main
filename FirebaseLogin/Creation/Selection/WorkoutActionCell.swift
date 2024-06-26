//
//  WorkoutActionCell.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/24.
//

import UIKit

class WorkoutActionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        if let nameLabel = nameLabel {
            contentView.embedView(view: nameLabel)
        }
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCellShadowEffect(cornerRadius: 8)
    }
    
    func configure(with action: WorkoutAction) {
        nameLabel?.text = action.name
    }
}



