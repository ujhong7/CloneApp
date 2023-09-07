//
//  MainTabController.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/13.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        checkIfUserIsLoggedIn()
        // logout()
    }
    
    // MARK: - API
    
    // 로그인상태확인 (첫화면결정 < 로그인화면 or 피드화면 > )
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
   
    // MARK: - Helpers
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), slectedImage: #imageLiteral(resourceName: "home_selected"), rootviewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), slectedImage: #imageLiteral(resourceName: "search_selected"), rootviewController: SearchControllers())
        
        let image = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), slectedImage: #imageLiteral(resourceName: "plus_unselected"), rootviewController: ImageSelectorControllers())
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), slectedImage: #imageLiteral(resourceName: "like_selected"), rootviewController: NotificationsControllers())
        
        let profileLayout = UICollectionViewFlowLayout()
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), slectedImage: #imageLiteral(resourceName: "profile_selected"), rootviewController: ProfileController(collectionViewLayout: profileLayout))
        
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
