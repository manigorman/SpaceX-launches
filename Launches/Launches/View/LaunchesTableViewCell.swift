//
//  LaunchesTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 15.04.2022.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "LaunchesTableViewCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Card")
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let missionTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "LabelHighEmphasis")
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let missionDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "LabelMediumEmphasis")
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let isSuccessfullImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .link
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        contentView.backgroundColor = UIColor(named: "Background")
        stack.addArrangedSubview(missionTitle)
        stack.addArrangedSubview(missionDate)
        contentView.addSubview(cardView)
        cardView.addSubview(stack)
        cardView.addSubview(isSuccessfullImage)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            stack.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5),
            stack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            stack.heightAnchor.constraint(equalToConstant: 52),
            
            isSuccessfullImage.widthAnchor.constraint(equalToConstant: 32),
            isSuccessfullImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32),
            isSuccessfullImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            isSuccessfullImage.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    // MARK: - Methods
    
    public func configure(title: String, date: String, isSuccessfull: Bool) {
        self.missionTitle.text = title
        self.missionDate.text = date
        
        if isSuccessfull {
            self.isSuccessfullImage.image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
            self.isSuccessfullImage.tintColor = .systemGreen
        } else {
            self.isSuccessfullImage.image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
            self.isSuccessfullImage.tintColor = .systemRed
        }
    }
}
