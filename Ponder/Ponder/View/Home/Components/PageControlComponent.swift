//
//  PageControlComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PageControlComponent: UIView, Component {
    struct ViewModel {
        let totalPageCount: Int
        let currentPage: Int
    }
    
    private let pageControlBase: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.AppColors.lightGray.withAlphaComponent(0.25)
        return view
    }()
    
    private let pageControlStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private let currentPageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.georgia(size: 11)
        label.textColor = UIColor.AppColors.lightGray
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        pageControlStack.removeAllArrangedSubviews()
        let pageCap = viewModel.totalPageCount.correctTotalPage(perPage: 5, currentPage: viewModel.currentPage, totalPage: viewModel.totalPageCount)
        for index in 1...pageCap {
            pageControlStack.addArrangedSubviews(createPageView(shouldHighlight: index == viewModel.currentPage.correctPageIndex(perPage: 5)))
        }
        currentPageLabel.text = "Showing page \(viewModel.currentPage) out of \(viewModel.totalPageCount)"
    }
    
}

//MARK: - Private

private extension PageControlComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(pageControlBase, pageControlStack, currentPageLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            pageControlBase.heightAnchor.constraint(equalToConstant: 2.0),
            
            pageControlBase.centerYAnchor.constraint(equalTo: centerYAnchor),
            pageControlBase.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControlBase.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControlStack.topAnchor.constraint(equalTo: pageControlBase.topAnchor),
            pageControlStack.leadingAnchor.constraint(equalTo: pageControlBase.leadingAnchor),
            pageControlStack.trailingAnchor.constraint(equalTo: pageControlBase.trailingAnchor),
            pageControlStack.bottomAnchor.constraint(equalTo: pageControlBase.bottomAnchor),
            
            currentPageLabel.bottomAnchor.constraint(equalTo: pageControlStack.topAnchor, constant: -Spacing.sixteen),
            currentPageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func createPageView(shouldHighlight: Bool) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        if shouldHighlight {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .clear
        }
        return view
    }
}
