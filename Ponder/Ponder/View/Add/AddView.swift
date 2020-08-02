//
//  AddView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/1.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum AddViewTextFieldTags: Int {
    case title
    case poemContent
}

class AddView: UIView {
    private let backgroundOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.2)
        return view
    }()
    
    private let addContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Spacing.twentyFour
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let titleTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Title"
        textView.textColor = UIColor.AppColors.lightGray
        textView.isScrollEnabled = false
        textView.font = UIFont.georgiaBold(size: 23)
        textView.tag = AddViewTextFieldTags.title.rawValue
        return textView
    }()
    
    let poemTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Start Writing"
        textView.textColor = UIColor.AppColors.gray
        textView.font = UIFont.georgia(size: 16)
        textView.tag = AddViewTextFieldTags.poemContent.rawValue
        return textView
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

private extension AddView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()

    }
    
    func configureSubviews() {
        addSubviews(backgroundOverlayView, closeButton, nextButton, addContentView)
        addContentView.addSubviews(titleTextField, poemTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: topAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.four),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            nextButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.four),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            addContentView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Spacing.sixteen),
            addContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.twentyFour),
            
            titleTextField.topAnchor.constraint(equalTo: addContentView.topAnchor, constant: Spacing.fortyEight),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            poemTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Spacing.thirtyTwo),
            poemTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            poemTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.sixteen)
        ])
    }
    
    func setupTextView() {
        titleTextField.delegate = self
        poemTextField.delegate = self
    }
}

//MARK: - TextView Delegate

extension AddView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.AppColors.lightGray || textView.textColor == UIColor.AppColors.gray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView.tag {
        case AddViewTextFieldTags.title.rawValue:
            if textView.text == "" {
                textView.text = "Title"
                textView.textColor = UIColor.AppColors.lightGray
            }
        case AddViewTextFieldTags.poemContent.rawValue:
            if textView.text == "" {
                textView.text = "Start writing"
                textView.textColor = UIColor.AppColors.gray
            }
        default:
            return
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        switch textView.tag {
//        case AddViewTextFieldTags.title.rawValue:
//            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//            return newText.count < 20
//        default:
//            return true
//        }
//    }
}

