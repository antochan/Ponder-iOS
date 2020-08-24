//
//  ListTextComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/19.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum ListTextStyle {
    case bothDividers
    case topDividerOnly
    case bottomDividerOnly
    case noDividers
}

protocol ListTextDelegate: AnyObject {
    func enteredText(text: String, listTextType: ListTextType)
}

public enum ListTextType {
    case email
    case password
    case username
    
    public var placeholderText: String {
        switch self {
        case .email:
            return "Enter your email"
        case .password:
            return "Enter your password"
        case .username:
            return "Enter your handle"
        }
    }
    
    public var titleText: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .username:
            return "Username"
        }
    }
    
    public var shouldSecureEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}

class ListTextComponent: UIView, Component, Reusable {
    weak var delegate: ListTextDelegate?
    private var listTextType: ListTextType?
    private var placeholder = ""
    
    struct ViewModel {
        let listTextType: ListTextType
        let listTextStyle: ListTextStyle
    }
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.main(size: 16)
        return label
    }()
    
    private let listTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.AppColors.lightGray
        textView.isScrollEnabled = false
        textView.font = UIFont.main(size: 16)
        textView.autocapitalizationType = .none
        return textView
    }()
    
    private let topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        listTextType = viewModel.listTextType
        placeholder = viewModel.listTextType.placeholderText
        titleLabel.text = viewModel.listTextType.titleText
        listTextField.text = viewModel.listTextType.placeholderText
        
        listTextField.isSecureTextEntry = viewModel.listTextType.shouldSecureEntry
        
        switch viewModel.listTextStyle {
        case .bothDividers:
            topDivider.isHidden = false
            bottomDivider.isHidden = false
        case .topDividerOnly:
            topDivider.isHidden = false
            bottomDivider.isHidden = true
        case .bottomDividerOnly:
            topDivider.isHidden = true
            bottomDivider.isHidden = false
        case .noDividers:
            topDivider.isHidden = true
            bottomDivider.isHidden = true
        }
    }
    
    func prepareForReuse() {
        titleLabel.text = nil
    }
}

//MARK: - Private

private extension ListTextComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        listTextField.delegate = self
        addSubview(mainStack)
        mainStack.addArrangedSubviews(topDivider, contentStack, bottomDivider)
        contentStack.addArrangedSubviews(titleLabel, listTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
}

//MARK: - TextView Delegate

extension ListTextComponent: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.AppColors.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
            textView.textColor = UIColor.AppColors.lightGray
        } else {
            guard let textType = listTextType else { return }
            delegate?.enteredText(text: textView.text, listTextType: textType)
        }
    }
}
