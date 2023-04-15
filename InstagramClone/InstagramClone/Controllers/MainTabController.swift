//
//  MainTabController.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/13.
//

import UIKit


class MainTabController: UITabBarController {
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), slectedImage: #imageLiteral(resourceName: "home_selected"), rootviewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), slectedImage: #imageLiteral(resourceName: "search_selected"), rootviewController: SearchControllers())
        let image = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), slectedImage: #imageLiteral(resourceName: "plus_unselected"), rootviewController: ImageSelectorControllers())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), slectedImage: #imageLiteral(resourceName: "like_selected"), rootviewController: NotificationsControllers())
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), slectedImage: #imageLiteral(resourceName: "profile_selected"), rootviewController: ProfileControllers())
        
        viewControllers = [feed, search, image, notifications, profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, slectedImage: UIImage, rootviewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootviewController)
    
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.image = slectedImage
        nav.navigationBar.tintColor = .black

        return nav
    }
    
    
    
}
