//
//  HomeExpandViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/27.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

protocol HomeExpandDelegate: AnyObject {
    func expandedDismissed()
}

class HomeExpandViewController: UIViewController {
    let homeExpandview = HomeExpandView()
    
    private let poem: Poem
    weak var delegate: HomeExpandDelegate?
    
    override func loadView() {
        super.loadView()
        view = homeExpandview
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
        homeExpandview.applyPoem(poem: poem)
        homeExpandview.dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeGesture.direction = [.down]
        homeExpandview.addGestureRecognizer(swipeGesture)
        
    }
    
    @objc func dismissTapped() {
        dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.expandedDismissed()
        }
    }
    
    @objc func swipeDown() {
        dismissTapped()
    }
}
