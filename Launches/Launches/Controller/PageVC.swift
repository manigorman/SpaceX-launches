//
//  ViewController.swift
//  Launches
//
//  Created by Igor Manakov on 30.03.2022.
//

import UIKit

var allRockets: [Rocket] = []

class PageVC: UIPageViewController {
    
    // MARK: - Properties
    
    private var pages = [UIViewController]()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .systemGray2
        
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                allRockets = rockets
                DispatchQueue.main.async {
                    self?.configurePages()
                }
            case .failure(let error):
                print(error)
            }
        }
        setupViews()
        setConstraints()
        setDelegate()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        
        view.backgroundColor = .purple
        
        view.addSubview(pageControl)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
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
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: false, completion: nil)
    }
    
    private func configurePages() {
        /// create an array of viewController
        for rocket in allRockets {
            let page = RocketVC()
//            let navVC = UINavigationController(rootViewController: page)
//            navVC.isNavigationBarHidden = true
            page.headerLink = rocket.flickr_images.randomElement() ?? ""
            page.configure(with: rocket)
            pages.append(page)
            
        }
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
//            return pages.last               // wrap to last
            return nil
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
//            return pages.first              // wrap to first
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
