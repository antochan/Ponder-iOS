//
//  HomeView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeView: UIView {
    private let poemCarousel: PoemCarouselComponent = {
        let carousel = PoemCarouselComponent()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyPoems(poems: PoemCarouselData) {
        poemCarousel.apply(viewModel: PoemCarouselComponent.ViewModel(carouselData: poems))
    }
}

//MARK: - Private

private extension HomeView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(poemCarousel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemCarousel.topAnchor.constraint(equalTo: topAnchor),
            poemCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemCarousel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
}
