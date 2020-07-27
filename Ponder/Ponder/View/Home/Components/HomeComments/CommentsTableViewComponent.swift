//
//  CommentsTableViewComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CommentsTableViewComponent: UIView, Component {
    struct ViewModel {
        let currentUser: User?
        let comments: [Comment]
        
        init(currentUser: User?, comments: [Comment]) {
            self.currentUser = currentUser
            self.comments = comments
        }
        
        static let defaultViewModel = ViewModel(currentUser: nil, comments: [])
    }
    
    private var viewModel = ViewModel.defaultViewModel {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let commentInputView: CommentTextFieldComponent = {
        let inputView = CommentTextFieldComponent()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        return inputView
    }()
    
    private let noCommentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main(size: 14)
        label.text = "No comments yet, be the first to comment below!"
        label.textAlignment = .center
        label.textColor = UIColor.AppColors.lightGray
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        commentInputView.apply(viewModel: CommentTextFieldComponent.ViewModel(user: viewModel.currentUser))
        self.viewModel = viewModel
        noCommentLabel.isHidden = !viewModel.comments.isEmpty
    }
}

//MARK: - Private

private extension CommentsTableViewComponent {
    func commonInit() {
        configureTableView()
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(commentInputView, tableView, noCommentLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            commentInputView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: commentInputView.topAnchor),
            
            noCommentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            noCommentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            noCommentLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ComponentTableViewCell<CommentsComponent>.self, forCellReuseIdentifier: "Comments")
    }
}

//MARK: - TableView Delegate & DataSource

extension CommentsTableViewComponent: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comments", for: indexPath) as! ComponentTableViewCell<CommentsComponent>
        cell.selectionStyle = .none
        let cellVM = ComponentTableViewCell<CommentsComponent>.ViewModel(componentViewModel: CommentsComponent.ViewModel(comment: viewModel.comments[indexPath.row]))
        cell.apply(viewModel: cellVM)
        return cell
    }
}
