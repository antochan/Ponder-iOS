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
    
    func setupTabBar() {
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
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.image = UIImage(named: "Home_Unselected")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "Home_Selected")
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem.image = UIImage(named: "Search_Unselected")
        searchViewController.tabBarItem.selectedImage = UIImage(named: "Search_Selected")
        
        viewControllers = [homeViewController, searchViewController]
    }
    
    func setupTabItemInsets() {
        guard let items = tabBar.items else { return }
        items.forEach { $0.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0) }
    }
}
