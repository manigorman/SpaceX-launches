//
//  TableHeader.swift
//  Launches
//
//  Created by Igor Manakov on 10.04.2022.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {

    static let identifier = "TableHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Custom Header"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
//        contentView.backgroundColor = .link
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        
        setConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
//            label.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    public func configure(with title: String) {
        self.label.text = title
    }
}
