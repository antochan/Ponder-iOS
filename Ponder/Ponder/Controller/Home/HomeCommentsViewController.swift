//
//  HomeCommentsViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

protocol HomeCommentsDelegate: AnyObject {
    func dismissed()
}

class HomeCommentsViewController: UIViewController {
    let homeCommentView = HomeCommentsView()
    
    private let poem: Poem
    weak var delegate: HomeCommentsDelegate?
    
    override func loadView() {
        super.loadView()
        view = homeCommentView
    }
    
    init(poem: Poem) {
        self.poem = poem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        homeCommentView.dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        homeCommentView.applyPoem(poem: poem)
    }
    
    
    @objc func dismissTapped() {
        dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.dismissed()
        }
    }
}
