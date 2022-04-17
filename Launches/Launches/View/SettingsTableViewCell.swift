//
//  SettingsTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "SettingsTableViewCell"
    
    var changedSegmentAction: (() -> ())?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "LabelHighEmphasis")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(changeUnit(_:)), for: .valueChanged)
        
        return segment
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
        contentView.addSubview(label)
        contentView.addSubview(segmentedControl)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    public func configure(with text: String, items: [String], chosen: Int) {
        self.label.text = text
        self.segmentedControl.insertSegment(withTitle: items[0], at: 0, animated: false)
        self.segmentedControl.insertSegment(withTitle: items[1], at: 1, animated: false)
        self.segmentedControl.selectedSegmentIndex = chosen
    }
    
    // MARK: - Selectors
    
    @objc func changeUnit(_ sender: UISegmentedControl) {
        changedSegmentAction?()
    }

}
