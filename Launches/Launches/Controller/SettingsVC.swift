//
//  SettingsViewController.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.allowsSelection = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
//        table.backgroundColor = UIColor(named: "Background")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Настройки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(handleDone))
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "LabelHighEmphasis")]
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc private func handleDone() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: "jalkfjkal", items: ["a", "b"])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        40
//    }
    
    
}
