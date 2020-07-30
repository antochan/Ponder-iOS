//
//  HomeViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/22.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Hero

class HomeViewController: UIViewController {
    let homeView = HomeView()
    
    private var currentPage: Int = 1 {
        didSet {
            homeView.applyPoemDetails(poem: mockPoemData.poems[currentPage - 1], totalPage: mockPoemData.poems.count, currentPage: currentPage)
        }
    }
    
    let mockUser = User(id: "123", profilePicture: #imageLiteral(resourceName: "Me copy"), username: "AntoGOV")
    
    let mockPoemData: PoemCarouselData = PoemCarouselData(poems: [
        Poem(id: "1",
             poemImage: #imageLiteral(resourceName: "Engage your customers"),
             title: "When designer forgets to tell you about Title",
             poemContent: "you fit into me\nlike a hook into an eye\na fish hook\nan open eye\ntest new line\nthis is 6th line\nthisis 7th line!\na fish hook\na fish hook\na fish hook\na fish hook",
             poemTags: ["#Fish", "#Swag", "#Eyes", "#Simple", "#DailyPoetry", "#Inspiration"],
             comments: [Comment(user: User(id: "1", profilePicture: #imageLiteral(resourceName: "User_Unselected"), username: "Hiroo Aoy."), comment: "Amazing, super inspirational! Lets test a super long comments see what happens!"),
                        Comment(user: User(id: "2", profilePicture: #imageLiteral(resourceName: "User_Unselected"), username: "Antochan101"), comment: "^Agreed! Amazing poem!!")],
             author: "Antonio",
             likes: 10),
        Poem(id: "2",
             poemImage: #imageLiteral(resourceName: "Build faster"),
             title: nil,
             poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left",
             poemTags: ["#Destiny", "#Daily Poem", "#ForYouPage", "#HypeTrain", "#Developers"],
             comments: [],
             author: "Hiroo",
             likes: 8),
        Poem(id: "3",
             poemImage: #imageLiteral(resourceName: "girl_abstract"),
             title: "When designer forgets to tell you about Title",
             poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto",
             poemTags: ["#Test", "#Swag"],
             comments: [],
             author: "Spike",
             likes: 44),
        Poem(id: "4",
             poemImage: #imageLiteral(resourceName: "Engage your customers"),
             title: "When designer forgets to tell you about Title",
             poemContent: "you fit into me\nlike a hook into an eye\na fish hook\n an open eye",
             poemTags: ["#Test", "#Swag"],
             comments: [],
             author: "Antonio",
             likes: 10),
        Poem(id: "5",
             poemImage: #imageLiteral(resourceName: "Build faster"),
             title: "When designer forgets to tell you about Title",
             poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left",
             poemTags: ["#Test", "#Swag"],
             comments: [],
             author: "Hiroo",
             likes: 8),
        Poem(id: "6",
             poemImage: #imageLiteral(resourceName: "girl_abstract"),
             title: "When designer forgets to tell you about Title",
             poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto",
             poemTags: ["#Test", "#Swag"],
             comments: [], author: "Spike",
             likes: 44)
    ])
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        homeView.delegate = self
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeGesture.direction = [.up]
        homeView.addGestureRecognizer(swipeGesture)
        homeView.applyPoemList(poems: mockPoemData)
        homeView.applyPoemDetails(poem: mockPoemData.poems[currentPage - 1], totalPage: mockPoemData.poems.count, currentPage: currentPage)
    }
    
    @objc func swipeUp() {
        if mockPoemData.poems[currentPage - 1].poemContent.numberOfLines() > Lines.staticLine {
            displayExpand()
        }
    }
    
    func displayExpand() {
        let homeExpandViewController = HomeExpandViewController(poem: mockPoemData.poems[currentPage - 1])
        homeView.setupHeroId(shouldAddHero: true, currentPage: currentPage)
        homeExpandViewController.delegate = self
        homeExpandViewController.modalPresentationStyle = .fullScreen
        homeExpandViewController.isHeroEnabled = true
        present(homeExpandViewController, animated: true) {
            homeExpandViewController.isViewPresented = true
        }
    }
    
}

//MARK: - HomePageDelegate

extension HomeViewController: HomePageDelegate {
    func iconTapped(buttonType: HomeIconType) {
        switch buttonType {
        case .like:
            print(mockPoemData.poems[currentPage - 1])
        case .comments:
            homeView.setupHeroId(shouldAddHero: true, currentPage: currentPage)
            let commentsViewController = HomeCommentsViewController(poem: mockPoemData.poems[currentPage - 1], user: mockUser)
            commentsViewController.delegate = self
            commentsViewController.modalPresentationStyle = .fullScreen
            commentsViewController.isHeroEnabled = true
            present(commentsViewController, animated: true)
        case .more:
            print(mockPoemData.poems[currentPage - 1])
        }
    }
    
    func pageChanged(newPage: Int) {
        currentPage = newPage
    }
    
    func readMoreTapped(poem: Poem) {
        displayExpand()
    }
}

//MARK: - HomeCommentsDelegate

extension HomeViewController: HomeCommentsDelegate {
    func dismissed() {
        homeView.setupHeroId(shouldAddHero: false, currentPage: currentPage)
    }
}

//MARK: - HomeExpandDelegate

extension HomeViewController: HomeExpandDelegate {
    func expandedDismissed() {
        homeView.setupHeroId(shouldAddHero: false, currentPage: currentPage)
    }
}
