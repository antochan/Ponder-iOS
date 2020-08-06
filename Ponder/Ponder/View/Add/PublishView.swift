//
//  PublishView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/4.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PublishView: UIView {
    private let poemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let poemImageOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let publishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Publish", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 18)
        button.setTitleColor(.black, for: .normal)
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
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let poemContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 16)
        label.numberOfLines = Lines.staticLine
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyPublishView(poemContent: PoemText, poemMedia: PickMedia) {
        poemImageView.image = poemMedia.mediaImage
        poemTitleLabel.isHidden = poemContent.title == ""
        poemTitleLabel.text = poemContent.title
        updatePoemLabel(poemText: poemContent.poemContent)
    }
    
    func updatePoemLabel(poemText: String) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
        
        poemContentLabel.numberOfLines = 6
    }
    
}

//MARK: - Private

private extension PublishView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, poemImageOverlayView, backButton, publishButton, poemContentStack)
        poemContentStack.addArrangedSubviews(poemTitleLabel, poemContentLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (HomeConstants.imageHeightMultiplier * HomeConstants.carouselHeightMultiplier)),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            publishButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            publishButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            poemContentStack.topAnchor.constraint(equalTo: poemImageOverlayView.bottomAnchor, constant: Spacing.twentyFour),
            poemContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
