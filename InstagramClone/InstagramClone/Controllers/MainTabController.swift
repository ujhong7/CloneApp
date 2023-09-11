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
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 현재 사용자가 로그인되어 있는지 확인하고, 만약 로그인되어 있지 않다면 로그인 화면(LoginController)을 표시합니다.
        // 따라서 앱이 실행될 때 또는 탭 바 컨트롤러(MainTabController)가 생성될 때
        // 사용자가 로그인한 상태인지 확인하기 위해 fetchUser 메서드가 호출됩니다.
        checkIfUserIsLoggedIn()
        fetchUser()
        // logout()
    }
    
    // MARK: - API
    
    // 현재 사용자의 정보를 가져오는 역할을 수행하여,
    // 앱의 초기화 단계나 사용자의 로그인 상태 변경 시에 사용됩니다.
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    // 로그인상태확인 (첫화면결정 < 로그인화면 or 피드화면 > )
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
   
    // MARK: - Helpers
    
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), slectedImage: #imageLiteral(resourceName: "home_selected"), rootviewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), slectedImage: #imageLiteral(resourceName: "search_selected"), rootviewController: SearchControllers())
        
        let image = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), slectedImage: #imageLiteral(resourceName: "plus_unselected"), rootviewController: ImageSelectorControllers())
        
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), slectedImage: #imageLiteral(resourceName: "like_selected"), rootviewController: NotificationsControllers())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), slectedImage: #imageLiteral(resourceName: "profile_selected"), rootviewController: profileController)
        
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

// MARK: - AuthenticationDelegate
 
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        // 로그인 또는 회원가입한 사용자의 정보를 가져오기 위해 fetchUser 메서드를 호출
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
