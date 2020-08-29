//
//  LoginView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/28.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class LoginView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "left-chevron"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 35)
        label.text = "Welcome Back"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let loginFormStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    let emailListComponent: ListTextComponent = {
        let component = ListTextComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.apply(viewModel: ListTextComponent.ViewModel(listTextType: .email, listTextStyle: .noDividers))
        return component
    }()
    
    let passwordListComponent: ListTextComponent = {
        let component = ListTextComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.apply(viewModel: ListTextComponent.ViewModel(listTextType: .password, listTextStyle: .noDividers))
        return component
    }()
    
    let loginButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Log in", backgroundColor: .black, borderColor: .black, textColor: .white))
        return button
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

private extension LoginView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backButton, titleLabel, loginFormStack, loginButton)
        loginFormStack.addArrangedSubviews(createDividerView(), emailListComponent, createDividerView(), passwordListComponent, createDividerView())
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.fortyEight),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIScreen.main.bounds.height * 0.25),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginFormStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginFormStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            loginFormStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            loginButton.topAnchor.constraint(equalTo: loginFormStack.bottomAnchor, constant: Spacing.twentyFour),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
