//
//  EmailSignupView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/19.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class EmailSignupView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "left-chevron"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 16)
        return button
    }()
    
    private let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 35)
        label.text = "Sign Up"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 17)
        label.text = "Step 1 out 3"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let emailListComponent: ListTextComponent = {
        let component = ListTextComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.apply(viewModel: ListTextComponent.ViewModel(listTextType: .email, listTextStyle: .bothDividers))
        return component
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(step: Int, totalSteps: Int) {
        subtitleLabel.text = "Step \(step) out \(totalSteps)"
    }
}

//MARK: - Private

private extension EmailSignupView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backButton, nextButton, titleStack, collectionView)
        titleStack.addArrangedSubviews(titleLabel, subtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.fortyEight),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            
            nextButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIScreen.main.bounds.height * 0.25),
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
