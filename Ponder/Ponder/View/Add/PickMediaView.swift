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

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        searchBar.placeholder = "Search Image"
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
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
        addSubviews(backgroundOverlayView, backButton, searchBar, tableView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: topAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            searchBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Spacing.eight),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.twentyFour)
        ])
    }
}
