//
//  PublishView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/4.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PublishView: UIView {
    private let poemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let poemImageOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let publishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Publish", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let poemContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let poemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgiaBold(size: 16)
        label.numberOfLines = 2
        label.textColor = .black
        label.hero.id = HeroIds.poemTitleView
        return label
    }()
    
    private let poemContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.georgia(size: 16)
        label.numberOfLines = Lines.staticLine
        label.hero.id = HeroIds.poemContentView
        label.textColor = .black
        return label
    }()
    
    let readMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.AppColors.lightGray
        label.text = "Tap here or swipe up to read more..."
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let addHashtagButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonVM = ButtonComponent.ViewModel(style: .minimal(UIColor.AppColors.lightGray), text: "Add hashtags", icon: #imageLiteral(resourceName: "plus"), backgroundColor: .white, borderColor: .white, textColor: .black)
        button.apply(viewModel: buttonVM)
        return button
    }()
    
    let hashtagTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = UIColor.AppColors.gray
        textfield.font = UIFont.main(size: 16)
        textfield.returnKeyType = .done
        return textfield
    }()
    
    let hashTagStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = Spacing.sixteen
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyPublishView(poemContent: PoemText, poemMedia: PickMedia) {
        poemImageView.image = poemMedia.mediaImage
        poemTitleLabel.isHidden = poemContent.title == ""
        poemTitleLabel.text = poemContent.title
        updatePoemLabel(poemText: poemContent.poemContent)
        readMoreLabel.isHidden = poemContent.poemContent.numberOfLines() <= Lines.staticLine
    }
    
    func applyAddHashtag(isAdding: Bool) {
        addHashtagButton.isHidden = isAdding
        hashtagTextField.isHidden = !isAdding
        if isAdding {
            hashtagTextField.becomeFirstResponder()
        }
    }
    
    func updatePoemLabel(poemText: String) {
        let attributedString = NSMutableAttributedString(string: poemText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Spacing.twelve
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        poemContentLabel.attributedText = attributedString
        
        poemContentLabel.numberOfLines = Lines.staticLine
    }
    
    func addHashtags(hashtags: [String]) {
        hashTagStack.removeAllArrangedSubviews()
        hashtags.forEach {
            let newHashTagView = HashtagView()
            newHashTagView.apply(viewModel: HashtagView.ViewModel(hashtagText: $0))
            hashTagStack.addArrangedSubviews(newHashTagView)
        }
    }
    
}

//MARK: - Private

private extension PublishView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(poemImageView, poemImageOverlayView, backButton, publishButton, poemContentStack, readMoreLabel, addHashtagButton, hashtagTextField, hashTagStack)
        poemContentStack.addArrangedSubviews(poemTitleLabel, poemContentLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            poemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: (HomeConstants.imageHeightMultiplier * HomeConstants.carouselHeightMultiplier)),
            
            poemImageOverlayView.topAnchor.constraint(equalTo: topAnchor),
            poemImageOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemImageOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemImageOverlayView.bottomAnchor.constraint(equalTo: poemImageView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            publishButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            publishButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            poemContentStack.topAnchor.constraint(equalTo: poemImageOverlayView.bottomAnchor, constant: Spacing.twentyFour),
            poemContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            poemContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            readMoreLabel.topAnchor.constraint(equalTo: poemContentStack.bottomAnchor, constant: Spacing.sixteen),
            readMoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            readMoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            addHashtagButton.topAnchor.constraint(equalTo: readMoreLabel.bottomAnchor, constant: Spacing.twentyFour),
            addHashtagButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            hashtagTextField.topAnchor.constraint(equalTo: readMoreLabel.bottomAnchor, constant: Spacing.twentyFour),
            hashtagTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            hashtagTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            
            hashTagStack.topAnchor.constraint(equalTo: hashtagTextField.bottomAnchor, constant: Spacing.thirtyTwo),
            hashTagStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            //hashTagStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour)
        ])
    }
}
