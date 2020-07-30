//
//  PoemContentComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Hero

class PoemContentComponent: UIView, Component, Reusable {
    public var actions: Actions?
    
    struct ViewModel {
        let poem: Poem
    }
    
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
    
    private let readMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.AppColors.lightGray
        label.text = "Tap here or swipe up to read more..."
        label.isUserInteractionEnabled = true
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
        poemImageView.image = viewModel.poem.poemImage
        poemTitleLabel.text = viewModel.poem.title
        poemTitleLabel.isHidden = viewModel.poem.title == nil
        updatePoemLabel(poemText: viewModel.poem.poemContent)
        readMoreLabel.isHidden = viewModel.poem.poemContent.numberOfLines() <= Lines.staticLine
    }
    
    func updatePoemLabel(poemText: String) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
        
        poemContentLabel.numberOfLines = Lines.staticLine
    }
    
    func prepareForReuse() {
        poemImageView.image = nil
        poemTitleLabel.text = nil
        poemContentLabel.text = nil
    }
    
    func setupHeroId(addHero: Bool) {
        poemContentLabel.hero.id = addHero ? HeroIds.poemContentView : nil
    }
}

//MARK: - Private

private extension PoemContentComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, poemImageOverlayView, poemContentStack, readMoreLabel)
        poemContentStack.addArrangedSubviews(poemTitleLabel, poemContentLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped))
        readMoreLabel.addGestureRecognizer(tap)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: HomeConstants.imageHeightMultiplier),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            poemContentStack.topAnchor.constraint(equalTo: poemImageOverlayView.bottomAnchor, constant: Spacing.twentyFour),
            poemContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            readMoreLabel.topAnchor.constraint(equalTo: poemContentStack.bottomAnchor, constant: Spacing.sixteen),
            readMoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            readMoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
    
    @objc func readMoreTapped() {
        actions?(.readMoreAction)
    }
}

//MARK: - Actionable

extension PoemContentComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case readMoreAction
    }
}
