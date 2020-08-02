//
//  PickMediaView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/2.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PickMediaView: UIView {
    private let backgroundOverlayView: UIView = {
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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.main(size: 18)
        button.setTitleColor(.black, for: .normal)
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

private extension PickMediaView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()

    }
    
    func configureSubviews() {
        addSubviews(backgroundOverlayView, backButton, nextButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: topAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            nextButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
        ])
    }
}
