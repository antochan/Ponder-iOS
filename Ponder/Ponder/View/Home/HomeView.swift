//
//  HomeView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeView: UIView {
    let poemContent: PoemContentComponent = {
        let poemContent = PoemContentComponent()
        poemContent.translatesAutoresizingMaskIntoConstraints = false
        poemContent.apply(viewModel: PoemContentComponent.ViewModel(poemImage: #imageLiteral(resourceName: "Build faster"), poemText: "they leave\nand act like it never happened\nthey come back\nand act like they never left", isExpanded: false))
        return poemContent
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private

private extension HomeView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(poemContent)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemContent.topAnchor.constraint(equalTo: topAnchor),
            poemContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemContent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
}
