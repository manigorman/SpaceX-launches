//
//  SeeLaunchesTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 08.04.2022.
//

import UIKit

class SeeLaunchesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "SeeLaunchesTableViewCell"
    
    var seeLaunchesButtonAction: (() -> ())?
    
    private let seeLaunchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(UIColor(named: "LabelHighEmphasis"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "Card")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(seeLaunchesButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubview(seeLaunchesButton)
        contentView.backgroundColor = UIColor(named: "Background")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            seeLaunchesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seeLaunchesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            seeLaunchesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeLaunchesButton.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    @objc private func seeLaunchesButtonPressed() {
        seeLaunchesButtonAction?()
    }
}
