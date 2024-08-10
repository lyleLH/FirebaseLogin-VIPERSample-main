//
//  SectionFooterView.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/28.
//

import UIKit

protocol SectionFooterViewDelegate: AnyObject {
    func didTapAddButton(in section: Int)
}

class SectionFooterView: UICollectionReusableView {
    static let reuseIdentifier = "SectionFooterView"
    
    weak var delegate: SectionFooterViewDelegate?
    var section: Int!
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Set", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonTapped() {
        delegate?.didTapAddButton(in: section)
    }
}
