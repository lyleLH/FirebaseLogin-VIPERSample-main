//
//  TrainingSetCell.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/28.
//

import UIKit
import SwipeCellKit

protocol TrainingSetCellDelegate: AnyObject {
    func didTapCompleteButton(in cell: TrainingSetCell)
}

class TrainingSetCell: SwipeCollectionViewCell {
    static let reuseIdentifier = "TrainingSetCell"
    
    weak var eventDelegate: TrainingSetCellDelegate?
    
    @IBOutlet weak var seclectionStatusColorView: UIView!
    var setNumberLabel: UILabel!
    var weightLabel: UILabel!
    var repetitionsLabel: UILabel!
    var completeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        addCellShadowEffect(cornerRadius: 8)
        
    }
    
    func setupViews() {
        setNumberLabel = UILabel()
        weightLabel = UILabel()
        repetitionsLabel = UILabel()
        completeButton = UIButton(type: .system)
        
        completeButton.setTitle("Complete", for: .normal)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [setNumberLabel, weightLabel, repetitionsLabel, completeButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with set: TrainingSet) {
        setNumberLabel.text = "Set \(set.setNumber)"
        weightLabel.text = "\(set.weight) kg"
        repetitionsLabel.text = "\(set.repetitions) reps"
        seclectionStatusColorView?.backgroundColor = set.isCompleted ? .lightGray : .white
    }
    
    @objc func completeButtonTapped() {
        eventDelegate?.didTapCompleteButton(in: self)
    }
}
