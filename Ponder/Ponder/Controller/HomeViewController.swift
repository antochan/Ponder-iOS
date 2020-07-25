//
//  HomeViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/22.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    
    private var currentPage: Int = 1 {
        didSet {
            homeView.applyPoemDetails(poem: mockPoemData.poems[currentPage - 1], totalPage: mockPoemData.poems.count, currentPage: currentPage)
        }
    }
    
    let mockPoemData: PoemCarouselData = PoemCarouselData(poems: [
        Poem(id: "1", poemImage: #imageLiteral(resourceName: "Engage your customers"), poemContent: "you fit into me\nlike a hook into an eye\na fish hook\n an open eye", poemTags: ["#Fish", "#Swag", "#Eyes", "Simple", "DailyPoetry", "Inspiration"], comments: [], author: "Antonio", likes: 10),
        Poem(id: "2", poemImage: #imageLiteral(resourceName: "Build faster"), poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left", poemTags: ["#Destiny", "#Daily Poem", "#ForYouPage", "#HypeTrain", "#Developers"], comments: [], author: "Hiroo", likes: 8),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "1", poemImage: #imageLiteral(resourceName: "Engage your customers"), poemContent: "you fit into me\nlike a hook into an eye\na fish hook\n an open eye", poemTags: ["#Test", "#Swag"], comments: [], author: "Antonio", likes: 10),
        Poem(id: "2", poemImage: #imageLiteral(resourceName: "Build faster"), poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left", poemTags: ["#Test", "#Swag"], comments: [], author: "Hiroo", likes: 8),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "2", poemImage: #imageLiteral(resourceName: "Build faster"), poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left", poemTags: ["#Test", "#Swag"], comments: [], author: "Hiroo", likes: 8),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44),
        Poem(id: "3", poemImage: #imageLiteral(resourceName: "girl_abstract"), poemContent: "Test Poem\nI am test\nHiroo Aoy\nAnto", poemTags: ["#Test", "#Swag"], comments: [], author: "Spike", likes: 44)
    ])
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        homeView.applyPoemList(poems: mockPoemData)
        homeView.applyPoemDetails(poem: mockPoemData.poems[currentPage - 1], totalPage: mockPoemData.poems.count, currentPage: currentPage)
    }
    
}

//MARK: - HomePageDelegate

extension HomeViewController: HomePageDelegate {
    func pageChanged(newPage: Int) {
        currentPage = newPage
    }
}
