//
//  TabBarController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/22.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

//MARK: - Private

private extension TabBarController {
    func setupTabBar() {
        delegate = self
        setupTabBarShadows()
        setupTabViewControllers()
        setupTabItemInsets()
    }
    
    func setupTabBarShadows() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.4
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 3
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = false
    }
    
    func setupTabViewControllers() {
        let homeViewController = createViewController(vc: HomeViewController(), selectedImage: #imageLiteral(resourceName: "Home_Selected"), unselectedImage: #imageLiteral(resourceName: "Home_Unselected"))
        let searchViewController = createViewController(vc: SearchViewController(), selectedImage: #imageLiteral(resourceName: "Search_Selected"), unselectedImage: #imageLiteral(resourceName: "Search_Unselected"))
        let addViewController = createViewController(vc: AddViewController(), selectedImage: #imageLiteral(resourceName: "Add_Selected"), unselectedImage: #imageLiteral(resourceName: "Add_Unselected"))
        let notificationViewController = createViewController(vc: NotificationViewController(), selectedImage: #imageLiteral(resourceName: "Bell_Selected"), unselectedImage: #imageLiteral(resourceName: "Bell_Unselected"))
        let accountViewController = createViewController(vc: AccountViewController(pageType: .own), selectedImage: #imageLiteral(resourceName: "User_Selected"), unselectedImage: #imageLiteral(resourceName: "User_Unselected"))
        viewControllers = [homeViewController, searchViewController, addViewController, notificationViewController, accountViewController]
    }
    
    func setupTabItemInsets() {
        guard let items = tabBar.items else { return }
        items.forEach { $0.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0) }
    }
    
    func createViewController(vc: UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UIViewController {
        vc.tabBarItem.image = unselectedImage
        vc.tabBarItem.selectedImage = selectedImage
        return vc
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddViewController {
            let addVC = AddViewController()
            addVC.modalPresentationStyle = .fullScreen
            tabBarController.present(addVC, animated: true)
            return false
        }
        return true
    }
}
