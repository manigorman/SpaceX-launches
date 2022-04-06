//
//  TitleTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 06.04.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TitleTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Falcon Heavy"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("✸", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(TitleTableViewCell.self, action: #selector(settingButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(settingButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            settingButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingButton.heightAnchor.constraint(equalToConstant: 28),
            settingButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    @objc private func settingButtonPressed() {
//        present(SettingsVC(), animated: true, completion: nil)
    }
}
