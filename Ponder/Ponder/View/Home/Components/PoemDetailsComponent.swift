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
        let totalPageCount: Int
        let currentPage: Int
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
        label.font = UIFont.georgia(size: 13)
        label.textColor = UIColor.AppColors.gray
        label.numberOfLines = 1
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 13)
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
    
    private let pageControl: PageControlComponent = {
        let pageControl = PageControlComponent()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let hashTagScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let hashTagStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let currentPageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 11)
        label.textColor = UIColor.AppColors.lightGray
        label.numberOfLines = 1
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
        nameLabel.text = viewModel.poem.author
        likesLabel.text = "\(viewModel.poem.likes) Likes"
        commentsLabel.text = "\(viewModel.poem.comments.count) Comments"
        
        pageControl.apply(viewModel: PageControlComponent.ViewModel(totalPageCount: viewModel.totalPageCount, currentPage: viewModel.currentPage))
        hashTagStack.removeAllArrangedSubviews()
        viewModel.poem.poemTags.forEach {
            hashTagStack.addArrangedSubviews(createHashTagLabel(hashtag: $0))
        }
        currentPageLabel.text = "Showing page \(viewModel.currentPage) out of \(viewModel.totalPageCount)"
    }
}

private extension PoemDetailsComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(mainSocialsStack, nameStack, pageControl, currentPageLabel, hashTagScrollView)
        hashTagScrollView.addSubview(hashTagStack)
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
            mainSocialsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            pageControl.bottomAnchor.constraint(equalTo: mainSocialsStack.topAnchor, constant: -Spacing.thirtyTwo),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            currentPageLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -Spacing.sixteen),
            currentPageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            hashTagScrollView.bottomAnchor.constraint(equalTo: currentPageLabel.topAnchor, constant: -Spacing.twelve),
            hashTagScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            hashTagScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            hashTagScrollView.topAnchor.constraint(equalTo: topAnchor),
            hashTagScrollView.heightAnchor.constraint(equalTo: hashTagStack.heightAnchor),
            
            hashTagStack.leadingAnchor.constraint(equalTo: hashTagScrollView.leadingAnchor),
            hashTagStack.trailingAnchor.constraint(equalTo: hashTagScrollView.trailingAnchor),
            hashTagStack.topAnchor.constraint(equalTo: hashTagScrollView.topAnchor),
            hashTagStack.bottomAnchor.constraint(equalTo: hashTagScrollView.bottomAnchor),
        ])
    }
    
    func createIconButton(image: UIImage) -> UIButton {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.widthAnchor.constraint(equalToConstant: 22).isActive = true
        button.setImage(image, for: .normal)
        return button
    }
    
    func createHashTagLabel(hashtag: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.AppColors.gray
        label.font = UIFont.georgia(size: 14)
        label.text = hashtag
        return label
    }
}
