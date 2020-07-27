//
//  HomeCommentsView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Hero

class HomeCommentsView: UIView {
    private let poemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let poemImageOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.2)
        return view
    }()
    
    private let poemContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Spacing.sixteen
        return view
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "chevron_down"), for: .normal)
        return button
    }()
    
    private let poemContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 16)
        label.textAlignment = .left
        label.numberOfLines = Lines.staticLine
        label.hero.id = HeroIds.poemContentView
        return label
    }()
    
    private let hashTagScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.hero.id = HeroIds.poemHashtagView
        return scrollView
    }()
    
    private let hashTagStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let headerDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.25)
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.hero.id = HeroIds.homePoemDividerView
        return view
    }()
    
    private let commentsTableView: CommentsTableViewComponent = {
        let commentsTable = CommentsTableViewComponent()
        commentsTable.translatesAutoresizingMaskIntoConstraints = false
        return commentsTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyPoem(poem: Poem) {
        poemImageView.image = poem.poemImage
        updatePoemLabel(poemText: poem.poemContent, isExpanded: false)
        hashTagStack.removeAllArrangedSubviews()
        poem.poemTags.forEach {
            hashTagStack.addArrangedSubviews(createHashTagLabel(hashtag: $0))
        }
        commentsTableView.apply(viewModel: CommentsTableViewComponent.ViewModel(currentUser: nil, comments: poem.comments))
    }
    
    func updatePoemLabel(poemText: String, isExpanded: Bool) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
        
        poemContentLabel.numberOfLines = isExpanded ? Lines.multiLine : Lines.staticLine
    }
}

//MARK: - Private

private extension HomeCommentsView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, poemImageOverlayView, poemContentView)
        poemContentView.addSubviews(dismissButton, poemContentLabel, hashTagScrollView, headerDividerView, commentsTableView)
        hashTagScrollView.addSubview(hashTagStack)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (HomeConstants.carouselHeightMultiplier * HomeConstants.imageHeightMultiplier)),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            poemContentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            poemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.sixteen),
            
            dismissButton.topAnchor.constraint(equalTo: poemContentView.topAnchor, constant: Spacing.sixteen),
            dismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: Spacing.sixteen),
            
            poemContentLabel.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: Spacing.twentyFour),
            poemContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            hashTagScrollView.topAnchor.constraint(equalTo: poemContentLabel.bottomAnchor, constant: Spacing.thirtyTwo),
            hashTagScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            hashTagScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            hashTagScrollView.heightAnchor.constraint(equalTo: hashTagStack.heightAnchor),
            
            hashTagStack.leadingAnchor.constraint(equalTo: hashTagScrollView.leadingAnchor),
            hashTagStack.trailingAnchor.constraint(equalTo: hashTagScrollView.trailingAnchor),
            hashTagStack.topAnchor.constraint(equalTo: hashTagScrollView.topAnchor),
            hashTagStack.bottomAnchor.constraint(equalTo: hashTagScrollView.bottomAnchor),
            
            headerDividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            headerDividerView.topAnchor.constraint(equalTo: hashTagStack.bottomAnchor, constant: Spacing.twentyFour),
            headerDividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            commentsTableView.topAnchor.constraint(equalTo: headerDividerView.bottomAnchor, constant: Spacing.twentyFour),
            commentsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            commentsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            commentsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.thirtyTwo)
        ])
    }
    
    func createHashTagLabel(hashtag: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.AppColors.gray
        label.font = UIFont.main(size: 14)
        label.text = hashtag
        return label
    }
}
