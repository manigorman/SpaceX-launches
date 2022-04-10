//
//  FeatureTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 10.04.2022.
//

import UIKit

class UniversalTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "UniversalTableViewCell"

    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "ThirdColor")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    public func configure(leftText: String, rightText: String) {
        self.leftLabel.text = leftText
        self.rightLabel.text = rightText
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }

}
