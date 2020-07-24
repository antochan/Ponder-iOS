//
//  PoemContentComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

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
    
    private let poemContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let poemContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 16)
        label.textAlignment = .left
        label.numberOfLines = 4
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
        
        poemContentLabel.numberOfLines = isExpanded ? 0 : 4
    }
    
    func prepareForReuse() {
        poemImageView.image = nil
        poemContentLabel.text = nil
    }
}

//MARK: - Private

private extension PoemContentComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(poemImageView)
        addSubview(poemImageOverlayView)
        addSubview(poemContentStack)
        poemContentStack.addArrangedSubview(poemContentLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            poemContentStack.topAnchor.constraint(equalTo: poemImageOverlayView.bottomAnchor, constant: Spacing.twentyFour),
            poemContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour)
        ])
    }
}
