//
//  StageFeaturesTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 07.04.2022.
//

import UIKit

class StageFeaturesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "StageFeaturesTableViewCell"
    
    private let featuresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let valuesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        featuresStack.addArrangedSubview(createFeatureLabel(with: "Количество двигателей"))
        featuresStack.addArrangedSubview(createFeatureLabel(with: "Количество топлива"))
        featuresStack.addArrangedSubview(createFeatureLabel(with: "Время сгорания"))
        
        valuesStack.addArrangedSubview(createFeatureLabel(with: "27"))
        valuesStack.addArrangedSubview(createFeatureLabel(with: "308.6"))
        valuesStack.addArrangedSubview(createFeatureLabel(with: "593 sec"))
        
        contentView.addSubview(featuresStack)
        contentView.addSubview(valuesStack)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createFeatureLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func createValueLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
//            featuresStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            featuresStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            featuresStack.topAnchor.constraint(equalTo: topAnchor),
            featuresStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            featuresStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            valuesStack.trailingAnchor.constraint(equalTo: trailingAnchor),
//            valuesStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            valuesStack.topAnchor.constraint(equalTo: topAnchor),
            valuesStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            valuesStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }

}
