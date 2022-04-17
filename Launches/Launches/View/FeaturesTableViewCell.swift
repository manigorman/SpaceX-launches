//
//  FeaturesCollectionTableViewCell.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class FeaturesTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "FeaturesTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 96, height: 96)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.register(FeaturesCollectionViewCell.self, forCellWithReuseIdentifier: FeaturesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var features = [Feature]()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        NotificationCenter.default.addObserver(self, selector: #selector(updateFeatures), name: NSNotification.Name.settingsChanged, object: nil)
        
        setupViews()
        setConstraints()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubview(collectionView)
        contentView.backgroundColor = UIColor(named: "Background")
        collectionView.backgroundColor = UIColor(named: "Background")
        contentView.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Methods
    
    public func configure(with model: FeaturesSection) {
        features = [
            Feature(title: "Высота, \(settings.height.description)", value: model.heightLabel),
            Feature(title: "Диаметр, \(settings.diameter.description)", value: model.diameterLabel),
            Feature(title: "Масса, \(settings.mass.description)", value: model.massLabel),
            Feature(title: "Нагрузка, \(settings.payload.description)", value: model.weightLabel)
        ]
    }
    
    @objc private func updateFeatures() {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
}

// MARK: - Extensions

extension FeaturesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturesCollectionViewCell.identifier, for: indexPath) as? FeaturesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: features[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
