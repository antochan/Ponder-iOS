//
//  PoemCarouselComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PoemCarouselComponent: UIView, Component, Actionable {
    struct ViewModel {
        var carouselData: PoemCarouselData
        
        init(carouselData: PoemCarouselData) {
            self.carouselData = carouselData
        }
        
        static let defaultViewModel = ViewModel(carouselData: PoemCarouselData(poems: []))
    }
    
    private var currentIndexPath: Int = 1 {
        didSet {
            actions?.currentPageHandler(currentIndexPath)
        }
    }
    
    private var viewModel = ViewModel.defaultViewModel {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var actions: Actions?
    
    public struct Actions {
        public typealias CurrentIndexHandler = (_ page: Int) -> Void
        let currentPageHandler: CurrentIndexHandler
        
        public init(currentPageHandler: @escaping CurrentIndexHandler) {
            self.currentPageHandler = currentPageHandler
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func apply(viewModel: ViewModel) {
        self.viewModel = ViewModel(carouselData: viewModel.carouselData)
    }
    
}

//MARK: - Private
private extension PoemCarouselComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        configureCollection()
    }
    
    func configureSubviews() {
        addSubview(collectionView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ComponentCollectionViewCell<PoemContentComponent>.self, forCellWithReuseIdentifier: "PoemContent")
    }
}

//MARK: - UICollectionView Delegate & DataSource

extension PoemCarouselComponent: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.carouselData.poems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoemContent", for: indexPath) as! ComponentCollectionViewCell<PoemContentComponent>
        let poem = viewModel.carouselData.poems[indexPath.row]
        let cellVM = ComponentCollectionViewCell<PoemContentComponent>.ViewModel(componentViewModel: PoemContentComponent.ViewModel(poemImage: poem.poemImage, poemText: poem.poemContent, isExpanded: false))
        cell.apply(viewModel: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func setupHeroId(shouldAddHero: Bool, currentPage: Int) {
        let cell = collectionView.cellForItem(at: IndexPath(item: currentPage - 1, section: 0)) as? ComponentCollectionViewCell<PoemContentComponent>
        cell?.component.setupHeroId(addHero: shouldAddHero)
    }
}

//MARK: - ScrollViewDelegate

extension PoemCarouselComponent {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getCurrentIndexPath(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            getCurrentIndexPath(scrollView)
        }
    }
    
    private func getCurrentIndexPath(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.bounds.width / 2.0
        collectionView.visibleCells.forEach { (cell) in
            if cell.frame.contains(CGPoint(x: centerX, y: cell.center.y)), let index = collectionView.indexPath(for: cell) {
                currentIndexPath = index.row + 1
            }
        }
    }
}
