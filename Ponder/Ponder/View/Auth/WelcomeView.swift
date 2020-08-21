//
//  WelcomeView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/18.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 42)
        label.text = "Welcome to Ponder"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let welcomeOptionsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    let signUpWithEmail: ListComponent = {
        let listComponent = ListComponent()
        listComponent.apply(viewModel: ListComponent.ViewModel(title: "Sign up using Email"))
        return listComponent
    }()
    
    let haveAnAccountLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.main(size: 15)
        label.text = "Have an account? Log in"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private

private extension WelcomeView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(titleLabel, welcomeOptionsStack, haveAnAccountLoginLabel)
        welcomeOptionsStack.addArrangedSubviews(createDividerView(), signUpWithEmail, createDividerView())
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIScreen.main.bounds.height * 0.25),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            welcomeOptionsStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0.1),
            welcomeOptionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            welcomeOptionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            haveAnAccountLoginLabel.topAnchor.constraint(equalTo: welcomeOptionsStack.bottomAnchor, constant: UIScreen.main.bounds.height * 0.15),
            haveAnAccountLoginLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
