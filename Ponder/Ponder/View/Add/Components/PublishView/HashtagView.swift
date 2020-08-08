//
//  HashtagVIew.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/6.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HashtagView: UIView, Component {
    struct ViewModel {
        let hashtagText: String
    }
    
    public var actions: Actions?
    public var key: String = ""
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.AppColors.gray
        label.font = UIFont.main(size: 16)
        return label
    }()
    
    private let xButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
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
        hashtagLabel.text = viewModel.hashtagText
        key = viewModel.hashtagText
    }
}

//MARK: - Private

private extension HashtagView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hashtagTapped))
        addGestureRecognizer(tap)
        addSubviews(hashtagLabel, xButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            hashtagLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.eight),
            hashtagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            hashtagLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hashtagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Spacing.eight),
            
            xButton.centerYAnchor.constraint(equalTo: hashtagLabel.centerYAnchor),
            xButton.heightAnchor.constraint(equalToConstant: 8),
            xButton.widthAnchor.constraint(equalToConstant: 8),
            xButton.leadingAnchor.constraint(equalTo: hashtagLabel.trailingAnchor, constant: Spacing.four),
            xButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func hashtagTapped() {
        actions?(.hashtagAction)
    }
}

//MARK: - Actionable
extension HashtagView: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case hashtagAction
    }
}
