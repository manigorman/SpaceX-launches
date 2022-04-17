//
//  ViewController.swift
//  Launches
//
//  Created by Igor Manakov on 30.03.2022.
//

import UIKit
import Network

var allRockets: [Rocket] = []
var allLaunches: [Launch] = []
var settings = UserSettings(height: .m, diameter: .m, mass: .kg, payload: .kg)

class PageVC: UIPageViewController {
    
    // MARK: - Properties
    
    private var pages = [UIViewController]()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    private let initialPage = 0
    
    // MARK: - Init
    
    init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(_:)), name: NSNotification.Name.connectivityStatus, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateFeatures), name: NSNotification.Name.settingsChanged, object: nil)
        
        if !UserDefaultsManager.shared.isExist(for: UserDefaultsManager.settingsKey) {
            UserDefaultsManager.shared.setData(with: settings, for: UserDefaultsManager.settingsKey)
        } else {
            UserDefaultsManager.shared.fetchData(with: UserDefaultsManager.settingsKey, completion: { result in
                switch result {
                case .success(let userSettings):
                    settings = userSettings
                    print(settings)
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        if NetworkMonitor.shared.isConnected {
            print("connected")
            fetchRocket()
            fetchLaunches()
        } else {
            DispatchQueue.main.async {
                self.performAlert()
            }
        }
    }
    
    // MARK: - Setup
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "Background")
        view.addSubview(pageControl)
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Selectors
    
    @objc func showOfflineDeviceUI(_ notification: Notification) {
        if !NetworkMonitor.shared.isConnected && !APICaller.areRocketsUploaded {
            fetchRocket()
        }
        else {
            print("already done")
        }
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: false, completion: nil)
    }
    
//    @objc private func updateFeatures() {
//        DispatchQueue.main.async {
//        }
//    }
    
    // MARK: - Methods
    
    private func fetchRocket() {
        APICaller.shared.getRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                allRockets = rockets
                //                DispatchQueue.main.async {
                //                    self?.configurePages()
                //                }
            case .failure(let error):
                print(error)
            }
        }
        print("Downloaded")
    }
    
    private func fetchLaunches() {
        APICaller.shared.getLaunches { [weak self] result in
            switch result {
            case .success(let launches):
                allLaunches = launches
                DispatchQueue.main.async {
                    self?.configurePages()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configurePages() {
        for rocket in allRockets {
            let page = RocketVC()
            page.headerLink = rocket.flickr_images.randomElement() ?? ""
            let currentRocketLaunches = allLaunches.filter {
                return $0.rocket! == rocket.id
            }
            page.configure(with: rocket, and: currentRocketLaunches)
            
            let navVC = UINavigationController(rootViewController: page)
            navVC.isNavigationBarHidden = true
            pages.append(navVC)
        }
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func performAlert() {
        
        let alertController = UIAlertController (title: "Warning", message: "Please connect to the Internet", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

extension PageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
