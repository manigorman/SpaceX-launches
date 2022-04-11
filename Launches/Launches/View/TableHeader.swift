//
//  TableHeader.swift
//  Launches
//
//  Created by Igor Manakov on 10.04.2022.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {

    // MARK: - Properties
    
    static let identifier = "TableHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = ""
        label.textColor = UIColor(named: "LabelHighEmphasis")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Methods
    
    public func configure(with title: String) {
        self.label.text = title
    }
}
