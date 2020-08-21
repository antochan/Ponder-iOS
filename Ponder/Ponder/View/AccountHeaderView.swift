//
//  AccountHeaderView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AccountHeaderView: UIView, Component {
    struct ViewModel {
        let accountpageType: AccountPageType
        let user: User
    }
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        return button
    }()
    
    let giftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "gift"), for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mainBold(size: 19)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mainItalic(size: 13)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = UIColor.AppColors.lightGray
        return label
    }()
    
    private let followStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.sixteen
        return stackView
    }()
    
    private let followerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.main(size: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = UIColor.AppColors.gray
        return label
    }()
    
    private let dotLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.textColor = UIColor.AppColors.gray
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.main(size: 14)
        label.textAlignment = .center
        label.textColor = UIColor.AppColors.gray
        
        label.numberOfLines = 1
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
        settingsButton.isHidden = viewModel.accountpageType == .other
        giftButton.isHidden = viewModel.accountpageType == .other
        profileImageView.image = viewModel.user.profilePicture
        nameLabel.text = viewModel.user.username
        bioLabel.isHidden = viewModel.user.bio == nil
        bioLabel.text = viewModel.user.bio
        followerLabel.text = "Follower \(viewModel.user.followerCount)"
        followingLabel.text = "Following \(viewModel.user.followingCount)"
    }
}

//MARK: - Private

private extension AccountHeaderView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(settingsButton, giftButton, stackView)
        stackView.addArrangedSubviews(profileImageView, nameLabel, bioLabel, followStack)
        followStack.addArrangedSubviews(followerLabel, dotLabel, followingLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),
            settingsButton.widthAnchor.constraint(equalToConstant: 20),
            
            giftButton.topAnchor.constraint(equalTo: topAnchor),
            giftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            giftButton.heightAnchor.constraint(equalToConstant: 20),
            giftButton.widthAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: giftButton.bottomAnchor, constant: Spacing.sixteen),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
