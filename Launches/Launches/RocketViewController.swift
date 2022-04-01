//
//  RocketViewController.swift
//  Launches
//
//  Created by Igor Manakov on 01.04.2022.
//

import UIKit

class RocketViewController: UIViewController {

    let stackView = UIStackView()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    init(titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        view.backgroundColor = .systemBackground
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 20
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
            subtitleLabel.textAlignment = .center
            
            subtitleLabel.numberOfLines = 0
        }
            
        func layout() {
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(subtitleLabel)
            
            view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                
                subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
            ])
        }

}
