//
//  ComponentCollectionViewCell.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class ComponentCollectionViewCell<T: Component & Reusable & UIView>: UICollectionViewCell, Pressable {
    public let configuration = PressableConfiguration(pressScale: .large)
    
    public let component = T(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override var isHighlighted: Bool {
        didSet {
            set(isPressed: isHighlighted,
                animated: true)
        }
    }
    
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(component)
    }
    
    func configureLayout() {
        component.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.four),
            component.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.eight),
            component.trailingAnchor.constraint(equalTo: trailingAnchor),
            component.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.four)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        component.prepareForReuse()
    }
}

extension ComponentCollectionViewCell {
    
    public struct ViewModel {
        public var componentViewModel: T.ViewModel
        
        public init(componentViewModel: T.ViewModel) {
            self.componentViewModel = componentViewModel
        }
    }
    
    func apply(viewModel: ComponentCollectionViewCell.ViewModel) {
        component.apply(viewModel: viewModel.componentViewModel)
    }
    
}

