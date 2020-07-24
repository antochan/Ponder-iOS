//
//  PoemCarouselComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PoemCarouselComponent: UIView, Component {
    struct ViewModel {
        var carouselData: PoemCarouselData
        
        init(carouselData: PoemCarouselData) {
            self.carouselData = carouselData
        }
        
        static let defaultViewModel = ViewModel(carouselData: PoemCarouselData(poems: []))
    }
    
    private var viewModel = ViewModel.defaultViewModel {
        didSet {
            collectionView.reloadData()
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350)
    }
    
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
}
