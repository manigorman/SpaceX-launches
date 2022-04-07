//
//  TitleTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 06.04.2022.
//

import UIKit

protocol SettingButtonPressedDelegate: AnyObject {
    func SettingButtonPressed(_ titleTableViewCell: TitleTableViewCell)
}

class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TitleTableViewCell"
    
    weak var delegate: SettingButtonPressedDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
        
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
//            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingButton.heightAnchor.constraint(equalToConstant: 28),
            settingButton.widthAnchor.constraint(equalToConstant: 28)
//            settingButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    public func configure(with model: TitleSection) {
        self.titleLabel.text = model.titleLabel
        self.settingButton.setImage(model.icon, for: .normal)
    }
    
    @objc private func settingButtonPressed() {
        self.delegate?.SettingButtonPressed(self)
    }
}

extension TitleTableViewCell: SettingButtonPressedDelegate {
    func SettingButtonPressed(_ titleTableViewCell: TitleTableViewCell) {
        
    }
}
