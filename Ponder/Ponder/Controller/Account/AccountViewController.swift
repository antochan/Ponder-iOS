//
//  AccountViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/22.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    let accountView = AccountView()
    
    private var pageType: AccountPageType
    let mockPoemData: PoemCarouselData = PoemCarouselData(poems: [
        Poem(id: "1",
             poemImage: #imageLiteral(resourceName: "Engage your customers"),
             title: "When designer forgets to tell you about Title",
             poemContent: "you fit into me\nlike a hook into an eye\na fish hook\nan open eye\ntest new line\nthis is 6th line\nthisis 7th line!\na fish hook\na fish hook\na fish hook\na fish hook",
             poemTags: ["#Fish", "#Swag", "#Eyes", "#Simple", "#DailyPoetry", "#Inspiration"],
             comments: [Comment(user: User(id: "1", profilePicture: #imageLiteral(resourceName: "User_Unselected"), username: "HirooAoy", bio: "Designer at heart", followerCount: 12, followingCount: 42), comment: "Great poen!!"),
                        Comment(user: User(id: "2", profilePicture: #imageLiteral(resourceName: "User_Unselected"), username: "Antochan101", bio: "Coder at heart", followerCount: 12, followingCount: 42), comment: "^Agreed!, Great poen!!")],
             author: "Antonio",
             likes: 10),
        Poem(id: "2",
             poemImage: #imageLiteral(resourceName: "Build faster"),
             title: nil,
             poemContent: "they leave\nand act like it never happened\nthey come back\nand act like they never left\ntest",
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
    
    init(pageType: AccountPageType) {
        self.pageType = pageType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = accountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        accountView.tableView.delegate = self
        accountView.tableView.dataSource = self
        accountView.tableView.register(ComponentTableViewCell<PoemContentComponent>.self, forCellReuseIdentifier: "AccountPoems")
        let accountheader = AccountHeaderView(frame: CGRect(x: 0, y: 0, width: accountView.tableView.frame.width, height: 250))
        accountheader.apply(viewModel: AccountHeaderView.ViewModel(accountpageType: .own, user: User(id: "2", profilePicture: #imageLiteral(resourceName: "Me copy"), username: "AntoGOV", bio: "Coder at heart", followerCount: 12, followingCount: 42)))
        accountView.tableView.tableHeaderView = accountheader
    }
}

//MARK: - UITableView Delegate & DataSource

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockPoemData.poems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountPoems", for: indexPath) as! ComponentTableViewCell<PoemContentComponent>
        let poem = mockPoemData.poems[indexPath.row]
        let cellVM = ComponentTableViewCell<PoemContentComponent>.ViewModel(componentViewModel: PoemContentComponent.ViewModel(poem: poem))
        cell.selectionStyle = .none
        cell.apply(viewModel: cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * HomeConstants.carouselHeightMultiplier
    }
}
