//
//  ListComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/18.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class ListComponent: UIView, Component {
    public var actions: Actions?
    
    struct ViewModel {
        let title: String
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.main(size: 16)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "chevron_right_gray")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
    }
}

//MARK: - Private

private extension ListComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(componentTapped))
        addGestureRecognizer(tap)
        addSubviews(titleLabel, imageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.eight),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.four),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.four),
            imageView.heightAnchor.constraint(equalToConstant: 13),
            imageView.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    @objc func componentTapped() {
        actions?(.componentAction)
    }
}

//MARK: - Actionable
extension ListComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case componentAction
    }
}
