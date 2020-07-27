//
//  CommentTextField.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/26.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CommentTextFieldComponent: UIView, Component {
    struct ViewModel {
        let user: User?
    }
    
    private let mainInputStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let inputStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let commentTextField: UITextView = {
        let textView = UITextView()
        textView.text = "Add a Comment"
        textView.textColor = UIColor.AppColors.lightGray
        textView.isScrollEnabled = false
        textView.font = UIFont.main(size: 15)
        return textView
    }()
    
    private let commentButton: ButtonComponent = {
        let button = ButtonComponent()
        let buttonVM = ButtonComponent.ViewModel(style: .primary, text: "Submit", backgroundColor: .black, borderColor: .black, textColor: .white)
        button.apply(viewModel: buttonVM)
        button.isHidden = true
        return button
    }()
    
    private let loginButton: ButtonComponent = {
        let button = ButtonComponent()
        let buttonVM = ButtonComponent.ViewModel(style: .primary, text: "Login / Sign Up", backgroundColor: .black, borderColor: .black, textColor: .white)
        button.apply(viewModel: buttonVM)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        profileImageView.image = viewModel.user?.profilePicture ?? #imageLiteral(resourceName: "User_Unselected")
        inputStack.isHidden = viewModel.user == nil
        loginButton.isHidden = !inputStack.isHidden
    }
}

//MARK: - Private

private extension CommentTextFieldComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        commentTextField.delegate = self
    }
    
    func configureSubviews() {
        addSubview(mainInputStack)
        mainInputStack.addArrangedSubviews(inputStack, commentButton, loginButton)
        inputStack.addArrangedSubviews(profileImageView, commentTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            
            mainInputStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.sixteen),
            mainInputStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainInputStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainInputStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.sixteen)
        ])
    }
}

//MARK: - TextView Delegate

extension CommentTextFieldComponent: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.AppColors.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Add a Comment"
            textView.textColor = UIColor.AppColors.lightGray
        }
        
        commentButton.isHidden = textView.text == "" || textView.textColor == UIColor.AppColors.lightGray
    }
}
