//
//  LaunchesVC.swift
//  Launches
//
//  Created by Igor Manakov on 11.04.2022.
//

import UIKit

class LaunchesVC: UIViewController {
    
    // MARK: - Properties
    
    private var launches: [Launch] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.allowsSelection = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        table.contentInset.bottom = UIApplication.shared.windows.first!.safeAreaInsets.bottom
        table.backgroundColor = UIColor(named: "Background")
        
        table.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.title = "Falcon"
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "Background")
        view.addSubview(tableView)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "LabelHighEmphasis") ?? .label]
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Methods
    
    public func configure(with launches: [Launch]) {
        self.launches = launches
    }
}

// MARK: - Extensions

extension LaunchesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.identifier, for: indexPath) as? LaunchesTableViewCell else {
            return UITableViewCell()
        }
        
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: launches[indexPath.row].date_unix!)
        dateFormatter.dateStyle = .long
        
        cell.configure(title: launches[indexPath.row].name!, date: dateFormatter.string(from: date), isSuccessfull: launches[indexPath.row].success ?? false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        116
    }
}

