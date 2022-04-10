//
//  RocketViewController.swift
//  Launches
//
//  Created by Igor Manakov on 01.04.2022.
//

import UIKit

enum SectionType {
    case titleSection(model: TitleSection)
    case featuresSection(model: FeaturesSection)
    case generalFeaturesSection(model: GeneralFeaturesSection)
    case stageFeaturesSection(model: StageFeaturesSection, header: String)
    case seeLaunchesSection
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

struct GeneralFeaturesSection {
    let firstFlightLabel: String
    let countryLabel: String
    let costPerLaunchLabel: Double
}

struct StageFeaturesSection {
    let engines: String
    let fuel_amount_tons: String
    let burn_time_sec: String
}

struct Feature {
    let title: String
    let value: String
}

class RocketVC: UIViewController {
    
    // MARK: - Properties
    
    private var models = [SectionType]()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.allowsSelection = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        
        table.register(FeaturesTableViewCell.self, forCellReuseIdentifier: FeaturesTableViewCell.identifier)
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        table.register(GeneralFeaturesTableViewCell.self, forCellReuseIdentifier: GeneralFeaturesTableViewCell.identifier)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: TableHeader.identifier)
        table.register(StageFeaturesTableViewCell.self, forCellReuseIdentifier: StageFeaturesTableViewCell.identifier)
        table.register(SeeLaunchesTableViewCell.self, forCellReuseIdentifier: SeeLaunchesTableViewCell.identifier)
        
        return table
    }()
    
    private var headerView: RocketHeaderView?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        headerView = RocketHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        tableView.tableHeaderView = headerView
        
        headerView?.imageView.image = UIImage(named: "image")
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
    
    func configure(with rocket: Rocket) {
        models.append(contentsOf: [.titleSection(model: TitleSection(titleLabel: rocket.name, icon: UIImage(named: "settingIcon")?.withRenderingMode(.alwaysTemplate), handler: {
            return
        })),
                                   .featuresSection(model: FeaturesSection(heightLabel: String(rocket.height.meters),
                                                                           diameterLabel: String(rocket.diameter.meters),
                                                                           massLabel: String(rocket.mass.kg),
                                                                           weightLabel: String(rocket.payload_weights[0].kg))),
                                   .generalFeaturesSection(model: GeneralFeaturesSection(firstFlightLabel: rocket.first_flight,
                                                                                         countryLabel: rocket.country,
                                                                                         costPerLaunchLabel: rocket.cost_per_launch)),
                                   .stageFeaturesSection(model: StageFeaturesSection(engines: String(rocket.first_stage.engines ?? 0),
                                                                                     fuel_amount_tons: String(rocket.first_stage.fuel_amount_tons ?? 0), burn_time_sec: String(rocket.first_stage.burn_time_sec ?? 0)), header: "ПЕРВАЯ СТУПЕНЬ"),
                                   .stageFeaturesSection(model: StageFeaturesSection(engines: String(rocket.second_stage.engines ?? 0),
                                                                                     fuel_amount_tons: String(rocket.second_stage.fuel_amount_tons ?? 0),
                                                                                     burn_time_sec: String(rocket.second_stage.burn_time_sec ?? 0)), header: "ВТОРАЯ СТУПЕНЬ"),
                                   .seeLaunchesSection
                                  ])
    }
    
}

// MARK: - Extensions

extension RocketVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
            cell.delegate = self
            
            return cell
        case .featuresSection(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesTableViewCell.identifier, for: indexPath) as? FeaturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        case .generalFeaturesSection(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralFeaturesTableViewCell.identifier, for: indexPath) as? GeneralFeaturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        case .stageFeaturesSection(let model, _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StageFeaturesTableViewCell.identifier, for: indexPath) as? StageFeaturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        case .seeLaunchesSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeeLaunchesTableViewCell.identifier, for: indexPath) as? SeeLaunchesTableViewCell else {
                return UITableViewCell()
            }
//            cell.delegate = self
            
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
            return 60
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
        case 2:
            return 96
        case 5:
            return 56
        default:
            return 96
        }
    }
}

extension RocketVC: SettingButtonPressedDelegate {
    func settingButtonUsage(_ titleTableViewCell: TitleTableViewCell) {
        let vc = SettingsVC()
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

extension RocketVC: SeeLaunchesButtonPressedDelegate {
    func seeLaunchesButtonUsage(_ seeLaunchesTableViewCell: SeeLaunchesTableViewCell) {
        let vc = SettingsVC()
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
