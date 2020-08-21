//
//  AccountView.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AccountView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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

//MARK: - Private

private extension AccountView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(tableView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
