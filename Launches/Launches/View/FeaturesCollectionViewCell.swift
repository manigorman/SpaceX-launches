//
//  FeaturesCollectionViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class FeaturesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "LabelMediumEmphasis")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "LabelLowEmphasis")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    static let identifier = "FeaturesCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        stack.addArrangedSubview(valueLabel)
        stack.addArrangedSubview(dimensionLabel)
        contentView.addSubview(stack)
        contentView.backgroundColor = UIColor(named: "Card")
        
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Methods
    
    public func configure(with model: Feature) {
        self.valueLabel.text = model.value
        self.dimensionLabel.text = model.title
    }
    
}
