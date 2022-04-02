//
//  SettingsTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "settingsCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var segmentedControl = UISegmentedControl(items: ["sadfa", "adfsfr"])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(segmentedControl)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            segmentedControl.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: topAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
    
    public func configure(with label: String, left: String, right: String) {
        self.label.text = label
    }

}
