//
//  PickMediaComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/2.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PickMediaComponent: UIView, Component, Reusable {
    struct ViewModel {
        let pickMedia: PickMedia
    }
    
    private let poemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        stackView.alignment = .center
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
        poemImageView.image = viewModel.pickMedia.mediaImage
        hashTagStack.removeAllArrangedSubviews()
        viewModel.pickMedia.hashtags.forEach {
            hashTagStack.addArrangedSubviews(createHashTagLabel(hashtag: $0))
        }
    }
    
    func prepareForReuse() {
        poemImageView.image = nil
    }
}

//MARK: - Private

private extension PickMediaComponent {
    func commonInit() {
        backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.3)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, hashTagScrollView)
        hashTagScrollView.addSubview(hashTagStack)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.3),
            
            hashTagScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            hashTagScrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hashTagScrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            hashTagScrollView.topAnchor.constraint(equalTo: poemImageView.bottomAnchor, constant: -Spacing.sixteen),
            hashTagScrollView.heightAnchor.constraint(equalTo: hashTagStack.heightAnchor),
            
            hashTagStack.leadingAnchor.constraint(equalTo: hashTagScrollView.leadingAnchor),
            hashTagStack.trailingAnchor.constraint(equalTo: hashTagScrollView.trailingAnchor),
            hashTagStack.topAnchor.constraint(equalTo: hashTagScrollView.topAnchor),
            hashTagStack.bottomAnchor.constraint(equalTo: hashTagScrollView.bottomAnchor),
        ])
    }
    
    func createHashTagLabel(hashtag: String) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.main(size: 16)
        label.text = hashtag
        return label
    }
}
