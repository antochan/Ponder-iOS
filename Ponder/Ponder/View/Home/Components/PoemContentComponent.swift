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
    struct ViewModel {
        let poemImage: UIImage
        let poemText: String
        let isExpanded: Bool
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
    
    private let poemContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 16)
        label.textAlignment = .left
        label.numberOfLines = Lines.staticLine
        label.textColor = .black
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
        poemImageView.image = viewModel.poemImage
        updatePoemLabel(poemText: viewModel.poemText, isExpanded: viewModel.isExpanded)
    }
    
    func updatePoemLabel(poemText: String, isExpanded: Bool) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
        
        poemContentLabel.numberOfLines = isExpanded ? Lines.multiLine : Lines.staticLine
    }
    
    func prepareForReuse() {
        poemImageView.image = nil
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
        addSubviews(poemImageView, poemImageOverlayView, poemContentLabel)
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
            
            poemContentLabel.topAnchor.constraint(equalTo: poemImageOverlayView.bottomAnchor, constant: Spacing.twentyFour),
            poemContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
