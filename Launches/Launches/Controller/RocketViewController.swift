//
//  RocketViewController.swift
//  Launches
//
//  Created by Igor Manakov on 01.04.2022.
//

import UIKit

class RocketViewController: UIViewController {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private var headerView: HeroHeaderView?
    
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
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        tableView.tableHeaderView = headerView
        headerView?.imageView.image = UIImage(named: "image")
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension RocketViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        label.text = "Section 1"
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row: \(indexPath.row+1)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? HeroHeaderView else {
            return
        }
        
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}
