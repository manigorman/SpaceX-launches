//
//  SettingsViewController.swift
//  Launches
//
//  Created by Igor Manakov on 02.04.2022.
//

import UIKit

struct Unit {
    let title: String
    let items: [String]
    var chosenUnit: Int
}

class SettingsVC: UIViewController {
    
    // MARK: - Properties
    
    var units = [Unit]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.allowsSelection = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
        units = [
            Unit(title: "Высота", items: LengthUnit.allCases.map { $0.description }, chosenUnit: settings.height.rawValue),
            Unit(title: "Диаметр", items: LengthUnit.allCases.map { $0.description }, chosenUnit: settings.diameter.rawValue),
            Unit(title: "Масса", items: MassUnit.allCases.map { $0.description }, chosenUnit: settings.mass.rawValue),
            Unit(title: "Полезная нагрузка", items: MassUnit.allCases.map { $0.description }, chosenUnit: settings.payload.rawValue)
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        settings = UserSettings(height: LengthUnit(rawValue: units[0].chosenUnit)!,
                                diameter: LengthUnit(rawValue: units[1].chosenUnit)!,
                                mass: MassUnit(rawValue: units[2].chosenUnit)!,
                                payload: MassUnit(rawValue: units[3].chosenUnit)!)
        UserDefaultsManager.shared.setData(with: settings, for: UserDefaultsManager.settingsKey)
        NotificationCenter.default.post(name: .settingsChanged, object: nil)
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        navigationItem.title = "Настройки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .done, target: self, action: #selector(handleDone))
        view.backgroundColor = .systemBackground
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
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Selectors
    
    @objc private func handleDone() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        units.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: units[indexPath.row].title, items: units[indexPath.row].items, chosen: units[indexPath.row].chosenUnit)
        
        cell.changedSegmentAction = { [unowned self] in
            self.units[indexPath.row].chosenUnit = (units[indexPath.row].chosenUnit + 1) % 2
        }
        
        return cell
    }
}
