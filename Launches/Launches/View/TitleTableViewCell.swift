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
    
    var settingButtonAction: (() -> ())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "LabelHighEmphasis")
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "LabelHighEmphasis")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(settingButton)
        contentView.backgroundColor = UIColor(named: "Background")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),

            
            settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingButton.heightAnchor.constraint(equalToConstant: 32),
            settingButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func settingButtonPressed() {
        settingButtonAction?()
    }
    
    // MARK: - Methods
    
    public func configure(with model: TitleSection) {
        self.titleLabel.text = model.titleLabel
        self.settingButton.setImage(model.icon, for: .normal)
    }
}
