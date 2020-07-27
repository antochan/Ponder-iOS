//
//  CommentsComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CommentsComponent: UIView, Component, Reusable {
    struct ViewModel {
        let comment: Comment
    }
    
    private let commentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mainMedium(size: 12)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 12)
        label.textColor = UIColor.AppColors.gray
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
        profileImageView.image = viewModel.comment.user.profilePicture
        usernameLabel.text = viewModel.comment.user.username
        commentLabel.text = viewModel.comment.comment
    }
    
    func prepareForReuse() {
        profileImageView.image = nil
        usernameLabel.text = nil
    }
}

//MARK: - Private

private extension CommentsComponent {
    func commonInit () {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(commentStack)
        commentStack.addArrangedSubviews(profileImageView, usernameLabel, commentLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([            
            commentStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.sixteen),
            commentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.sixteen)
        ])
    }
}
