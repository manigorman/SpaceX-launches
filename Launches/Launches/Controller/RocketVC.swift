//
//  RocketViewController.swift
//  Launches
//
//  Created by Igor Manakov on 01.04.2022.
//

import UIKit

class RocketVC: UIViewController {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FeaturesTableViewCell.self, forCellReuseIdentifier: FeaturesTableViewCell.identifier)
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        table.register(GeneralFeaturesTableViewCell.self, forCellReuseIdentifier: GeneralFeaturesTableViewCell.identifier)
        table.register(StageFeaturesTableViewCell.self, forCellReuseIdentifier: StageFeaturesTableViewCell.identifier)
        
        return table
    }()
    
    private var headerView: RocketHeaderView?
    
    // MARK: - Init
    
    init(titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        //        titleLabel.text = titleText
        //        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        headerView = RocketHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        
        tableView.tableHeaderView = headerView
        
        headerView?.imageView.image = UIImage(named: "image")
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - Extensions

extension RocketVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        label.text = "Section 1"
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesTableViewCell.identifier, for: indexPath) as? FeaturesTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralFeaturesTableViewCell.identifier, for: indexPath) as? GeneralFeaturesTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StageFeaturesTableViewCell.identifier, for: indexPath) as? StageFeaturesTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? RocketHeaderView else {
            return
        }
        
        header.scrollViewDidScroll(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 32
        case 1:
            return 96
        case 2:
            return 105
        default:
            return 105
        }
    }
}
