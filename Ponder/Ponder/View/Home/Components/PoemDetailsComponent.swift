//
//  PoemDetailsComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PoemDetailsComponent: UIView, Component {
    struct ViewModel {
        let poem: Poem
    }
    
    private let iconsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.thirtyTwo
        return stackView
    }()
    
    private let nameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgiaBold(size: 21)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 17)
        label.textColor = UIColor.AppColors.lightGray
        label.textAlignment = .right
        label.numberOfLines = 1
        label.text = "12 HRS"
        return label
    }()
    
    private let socialStatsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.sixteen
        stackView.alignment = .leading
        return stackView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 15)
        label.textColor = UIColor.AppColors.gray
        label.numberOfLines = 1
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 15)
        label.textColor = UIColor.AppColors.gray
        label.numberOfLines = 1
        return label
    }()
    
    private let mainSocialsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.sixteen
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        nameLabel.text = viewModel.poem.author
        likesLabel.text = "\(viewModel.poem.likes) Likes"
        commentsLabel.text = "\(viewModel.poem.comments.count) Comments"
    }
}

private extension PoemDetailsComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(mainSocialsStack, nameStack)
        mainSocialsStack.addArrangedSubviews(iconsStack, socialStatsStack)
        iconsStack.addArrangedSubviews(createIconButton(image: #imageLiteral(resourceName: "heart_empty")), createIconButton(image: #imageLiteral(resourceName: "Comment")), createIconButton(image: #imageLiteral(resourceName: "more")))
        nameStack.addArrangedSubviews(nameLabel, timeLabel)
        socialStatsStack.addArrangedSubviews(likesLabel, commentsLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            nameStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            mainSocialsStack.centerYAnchor.constraint(equalTo: nameStack.centerYAnchor),
            mainSocialsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour)
        ])
    }
    
    func createIconButton(image: UIImage) -> UIButton {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.widthAnchor.constraint(equalToConstant: 22).isActive = true
        button.setImage(image, for: .normal)
        return button
    }
}
