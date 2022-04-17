//
//  RocketViewController.swift
//  Launches
//
//  Created by Igor Manakov on 01.04.2022.
//

import UIKit

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

enum SectionType {
    case titleSection(model: TitleSection)
    case featuresSection(model: FeaturesSection)
    case generalFeaturesSection(model: [Feature])
    case stageFeaturesSection(model: [Feature], header: String)
    case seeLaunchesSection(title: String)
}

struct TitleSection {
    let titleLabel: String
    let icon: UIImage?
    let handler: (() -> Void)
}

struct FeaturesSection {
    let heightLabel: String
    let diameterLabel: String
    let massLabel: String
    let weightLabel: String
}

struct Feature {
    let title: String
    let value: String
}

class RocketVC: UIViewController {
    
    // MARK: - Properties
    
    private var models = [SectionType]()
    private var launches = [Launch]()
    
    private var rocket: Rocket? = nil
    
    public var headerLink = ""
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.allowsSelection = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        table.contentInset.bottom = UIApplication.shared.windows.first!.safeAreaInsets.bottom
        table.backgroundColor = UIColor(named: "Background")
        
        table.register(FeaturesTableViewCell.self, forCellReuseIdentifier: FeaturesTableViewCell.identifier)
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: TableHeader.identifier)
        table.register(SeeLaunchesTableViewCell.self, forCellReuseIdentifier: SeeLaunchesTableViewCell.identifier)
        table.register(UniversalTableViewCell.self, forCellReuseIdentifier: UniversalTableViewCell.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private var headerView: RocketHeaderView?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
        
        headerView?.configure(with: headerLink)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFeatures), name: NSNotification.Name.settingsChanged, object: nil)
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        
        view.backgroundColor = UIColor(named: "Background")
        view.addSubview(tableView)
        
        headerView = RocketHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        tableView.tableHeaderView = headerView
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Methods
    
    public func configure(with rocket: Rocket, and launches: [Launch]) {
        self.rocket = rocket
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: rocket.first_flight)
        dateFormatter.dateStyle = .long
        
        let height = settings.height.rawValue == 0 ? "\(rocket.height.meters.clean)" : "\(rocket.height.feet.clean)"
        let diameter = settings.diameter.rawValue == 0 ? "\(rocket.diameter.meters.clean)" : "\(rocket.diameter.feet.clean)"
        let mass = settings.mass.rawValue == 0 ? "\(rocket.mass.kg.clean)" : "\(rocket.mass.lb.clean)"
        let payload = settings.payload.rawValue == 0 ? "\(rocket.payload_weights[0].kg.clean)" : "\(rocket.payload_weights[0].lb.clean)"
        models = [
            .titleSection(model: TitleSection(titleLabel: rocket.name, icon: UIImage(named: "settingIcon")?.withRenderingMode(.alwaysTemplate), handler: {
                return
            })),
            .featuresSection(model: FeaturesSection(heightLabel: height,
                                                    diameterLabel: diameter,
                                                    massLabel: mass,
                                                    weightLabel: payload)),
            .generalFeaturesSection(model: [
                Feature(title: "Первый запуск", value: dateFormatter.string(from: date!)),
                Feature(title: "Страна", value: rocket.country),
                Feature(title: "Стоимость груза", value: "$\(rocket.cost_per_launch / 1000_000) млн")
            ]),
            .stageFeaturesSection(model: [
                Feature(title: "Количество двигателей", value: String(rocket.first_stage.engines ?? 0)),
                Feature(title: "Количество топлива", value: "\((rocket.first_stage.fuel_amount_tons ?? 0).clean) т"),
                Feature(title: "Время сгорания", value: "\(rocket.first_stage.burn_time_sec ?? 0) сек")
            ], header: "ПЕРВАЯ СТУПЕНЬ"),
            .stageFeaturesSection(model: [
                Feature(title: "Количество двигателей", value: String(rocket.second_stage.engines ?? 0)),
                Feature(title: "Количество топлива", value: "\((rocket.second_stage.fuel_amount_tons ?? 0).clean) т"),
                Feature(title: "Время сгорания", value: "\(rocket.second_stage.burn_time_sec ?? 0) сек")
            ], header: "ВТОРАЯ СТУПЕНЬ"),
            .seeLaunchesSection(title: rocket.name)
        ]
        self.launches = launches
    }
    
    // MARK: - Selectors
    
    @objc private func updateFeatures() {
        DispatchQueue.main.async {
            let height = settings.height.rawValue == 0 ? "\(self.rocket!.height.meters.clean)" : "\(self.rocket!.height.feet.clean)"
            let diameter = settings.diameter.rawValue == 0 ? "\(self.rocket!.diameter.meters.clean)" : "\(self.rocket!.diameter.feet.clean)"
            let mass = settings.mass.rawValue == 0 ? "\(self.rocket!.mass.kg.clean)" : "\(self.rocket!.mass.lb.clean)"
            let payload = settings.payload.rawValue == 0 ? "\(self.rocket!.payload_weights[0].kg.clean)" : "\(self.rocket!.payload_weights[0].lb.clean)"
            
            self.models[1] = .featuresSection(model: FeaturesSection(heightLabel: height,
                                                               diameterLabel: diameter,
                                                               massLabel: mass,
                                                               weightLabel: payload))
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extensions

extension RocketVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 3
        case 5:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch models[section] {
        case .stageFeaturesSection(_, let header):
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeader.identifier) as? TableHeader
            headerView?.configure(with: header)
            
            return headerView
            
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section]
        
        switch model.self {
        case .titleSection(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)

            cell.settingButtonAction = { [unowned self] in
                
                let vc = SettingsVC()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .pageSheet
                if #available(iOS 15.0, *) {
                    if let sheet = nav.sheetPresentationController {
                        sheet.detents = [.medium(), .large()]
                    }
                } else {
                    print("====")
                }
                self.present(nav, animated: true, completion: nil)
            }
            
            return cell
        case .featuresSection(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesTableViewCell.identifier, for: indexPath) as? FeaturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        case .generalFeaturesSection(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversalTableViewCell.identifier, for: indexPath) as? UniversalTableViewCell else {
                return UITableViewCell()
            }
            
            let currentRow = indexPath.row
            cell.configure(leftText: model[currentRow].title, rightText: model[currentRow].value)
            
            return cell
        case .stageFeaturesSection(let model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversalTableViewCell.identifier, for: indexPath) as? UniversalTableViewCell else {
                return UITableViewCell()
            }
            let currentRow = indexPath.row
            cell.configure(leftText: model[currentRow].title, rightText: model[currentRow].value)
            
            return cell
        case .seeLaunchesSection(let title):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeeLaunchesTableViewCell.identifier, for: indexPath) as? SeeLaunchesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.seeLaunchesButtonAction = { [unowned self] in
                
                let vc = LaunchesVC()
                vc.configure(with: launches)
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                
                nav.navigationBar.topItem?.title = title
                
                self.navigationController?.pushViewController(vc, animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 3, 4:
            return 32
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 32
        case 1:
            return 96
        case 5:
            return 56
        default:
            return 40
        }
    }
}
