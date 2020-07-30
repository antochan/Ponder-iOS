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
    private let user: User?
    weak var delegate: HomeCommentsDelegate?
    
    override func loadView() {
        super.loadView()
        view = homeCommentView
    }
    
    init(poem: Poem, user: User?) {
        self.poem = poem
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        homeCommentView.dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        homeCommentView.applyPoem(poem: poem, user: user)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeGesture.direction = [.down]
        homeCommentView.addGestureRecognizer(swipeGesture)
    }
    
    
    @objc func dismissTapped() {
        dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.dismissed()
        }
    }
    
    @objc func swipeDown() {
        dismissTapped()
    }
}
