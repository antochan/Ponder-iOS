//
//  HomeExpandView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/27.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeExpandView: UIView {
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
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.four, bottom: Spacing.eight, right: Spacing.eight)
        return button
    }()
    
    private let poemContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let poemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgiaBold(size: 16)
        label.hero.id = HeroIds.poemTitleView
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let poemContentLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.hero.id = HeroIds.poemContentView
        label.isScrollEnabled = true
        label.textContainer.lineFragmentPadding = 0
        label.isOpaque = false
        return label
    }()
    
    private let fadeCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 1
        return view
    }()
    
    var poemContentHeightAnchor: NSLayoutConstraint?
    
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
        poemTitleLabel.text = poem.title
        poemTitleLabel.isHidden = poem.title == nil
        updatePoemLabel(poemText: poem.poemContent)
    }
    
    func updatePoemLabel(poemText: String) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.georgia(size: 16), range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
    }
    
    func expandPoemText(shouldExpand: Bool) {
        
        poemContentHeightAnchor?.constant = shouldExpand ? HomeStackConstants.poemContentHeightExpanded : HomeStackConstants.poemContentExpandStaticHeight
        shouldExpand ? fadeCoverView.fadeOut(duration: 0.5) : fadeCoverView.fadeIn()
    }
}

//MARK: - Private

private extension HomeExpandView {
    func commonInit() {
        poemContentLabel.font = UIFont.georgia(size: 16)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, poemImageOverlayView, poemContentView)
        poemContentStack.addArrangedSubviews(poemTitleLabel, poemContentLabel)
        poemContentView.addSubviews(dismissButton, poemContentStack, fadeCoverView)
    }
    
    func configureLayout() {
        poemContentHeightAnchor = poemContentLabel.heightAnchor.constraint(equalToConstant: HomeStackConstants.poemContentExpandStaticHeight)
        poemContentHeightAnchor?.isActive = true
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (HomeConstants.carouselHeightMultiplier * HomeConstants.imageHeightMultiplier)),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            poemContentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: HomeStackConstants.homeMultiplierStatic),
            poemContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.sixteen),
            
            dismissButton.topAnchor.constraint(equalTo: poemContentView.topAnchor, constant: Spacing.four),
            dismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: HomeStackConstants.dismissButtonHeight),
            
            poemContentStack.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: Spacing.twelve),
            poemContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            fadeCoverView.topAnchor.constraint(equalTo: poemContentLabel.topAnchor, constant: HomeStackConstants.poemContentExpandStaticHeight),
            fadeCoverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fadeCoverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fadeCoverView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
