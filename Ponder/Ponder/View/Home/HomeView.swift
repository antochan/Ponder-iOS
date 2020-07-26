//
//  HomeView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Hero

protocol HomePageDelegate {
    func pageChanged(newPage: Int)
    func iconTapped(buttonType: HomeIconType)
}

class HomeView: UIView {
    private let poemCarousel: PoemCarouselComponent = {
        let carousel = PoemCarouselComponent()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    private let poemDetails: PoemDetailsComponent = {
        let details = PoemDetailsComponent()
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
    
    var delegate: HomePageDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyPoemList(poems: PoemCarouselData) {
        poemCarousel.apply(viewModel: PoemCarouselComponent.ViewModel(carouselData: poems))
        
    }
    
    func applyPoemDetails(poem: Poem, totalPage: Int, currentPage: Int) {
        poemDetails.apply(viewModel: PoemDetailsComponent.ViewModel(poem: poem, totalPageCount: totalPage, currentPage: currentPage))
    }
    
    func setupHeroId(shouldAddHero: Bool, currentPage: Int) {
        poemCarousel.setupHeroId(shouldAddHero: shouldAddHero, currentPage: currentPage)
    }
}

//MARK: - Private

private extension HomeView {
    func commonInit() {
        configureSubviews()
        configureLayout()
        setupActions()
    }
    
    func configureSubviews() {
        addSubviews(poemCarousel, poemDetails)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            poemCarousel.topAnchor.constraint(equalTo: topAnchor),
            poemCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemCarousel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: HomeConstants.carouselHeightMultiplier),
            
            poemDetails.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.twentyFour),
            poemDetails.leadingAnchor.constraint(equalTo: leadingAnchor),
            poemDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
            poemDetails.topAnchor.constraint(equalTo: poemCarousel.bottomAnchor, constant: Spacing.sixteen)
        ])
    }
    
    func setupActions() {
        poemDetails.delegate = self
        
        poemCarousel.actions = PoemCarouselComponent.Actions(currentPageHandler: { [weak self] currentPage in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.pageChanged(newPage: currentPage)
        })
    }
}


//MARK: - HomeIconDelegate

extension HomeView: HomeIconDelegate {
    func buttonTapped(buttonType: HomeIconType) {
        delegate?.iconTapped(buttonType: buttonType)
    }
}
