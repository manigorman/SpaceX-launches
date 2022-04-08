//
//  SeeLaunchesTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 08.04.2022.
//

import UIKit

protocol SeeLaunchesButtonPressedDelegate: AnyObject {
    func seeLaunchesButtonUsage(_ seeLaunchesTableViewCell: SeeLaunchesTableViewCell)
}

class SeeLaunchesTableViewCell: UITableViewCell {

    static let identifier = "SeeLaunchesTableViewCell"
    
    weak var delegate: SeeLaunchesTableViewCell?
    
    private let seeLaunchesButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setTitle("Посмотреть запуски", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "ItemBackground")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeLaunchesButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(seeLaunchesButton)
        
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
        self.delegate?.seeLaunchesButtonUsage(self)
    }
}

extension SeeLaunchesTableViewCell: SeeLaunchesButtonPressedDelegate {
    func seeLaunchesButtonUsage(_ seeLaunchesTableViewCell: SeeLaunchesTableViewCell) {
        
    }

}
