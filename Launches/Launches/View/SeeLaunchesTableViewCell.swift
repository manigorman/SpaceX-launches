//
//  SeeLaunchesTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 08.04.2022.
//

import UIKit

class SeeLaunchesTableViewCell: UITableViewCell {

    static let identifier = "SeeLaunchesTableViewCell"
    
    weak var delegate: SeeLaunchesTableViewCell?
    
    private let seeLaunchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(UIColor(named: "LabelHighEmphasis"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "Card")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeLaunchesButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(seeLaunchesButton)
        contentView.backgroundColor = UIColor(named: "Background")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            seeLaunchesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seeLaunchesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            seeLaunchesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeLaunchesButton.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
//    public func configure(with model: TitleSection) {
//        self.settingButton.setImage(model.icon, for: .normal)
//    }
    
    @objc private func seeLaunchesButtonPressed() {
        
    }
}
