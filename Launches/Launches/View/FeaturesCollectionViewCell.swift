//
//  FeaturesCollectionViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class FeaturesCollectionViewCell: UICollectionViewCell {
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "LabelMediumEmphasis")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "LabelLowEmphasis")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    static let identifier = "FeaturesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack.addArrangedSubview(valueLabel)
        stack.addArrangedSubview(dimensionLabel)
        contentView.addSubview(stack)
        contentView.backgroundColor = UIColor(named: "Card")
        setConstraints()
        
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    public func configure(with model: Feature) {
        self.valueLabel.text = model.value
        self.dimensionLabel.text = model.title
    }
    
    
    
    //       public func configure(with model: String) {
    //           guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
    //           DispatchQueue.global().async {
    //               guard let data = try? Data(contentsOf: url) else {return}
    //               DispatchQueue.main.async {
    //                   self.posterImageView.image = UIImage(data: data)
    //               }
    //           }
    //       }
    
}
