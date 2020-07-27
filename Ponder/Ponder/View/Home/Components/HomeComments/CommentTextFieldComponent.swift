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
    
    private let inputStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        profileImageView.image = viewModel.user?.profilePicture ?? #imageLiteral(resourceName: "User_Unselected")
    }
}

//MARK: - Private

private extension CommentTextFieldComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(inputStack)
        inputStack.addArrangedSubviews(profileImageView, commentTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            
            inputStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.sixteen),
            inputStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.sixteen)
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
}
