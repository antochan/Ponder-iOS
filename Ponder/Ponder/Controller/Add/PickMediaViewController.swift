//
//  PickMediaViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/2.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PickMediaViewController: UIViewController {
    let pickMediaView = PickMediaView()
    
    override func loadView() {
        super.loadView()
        view = pickMediaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupActions()
    }
    
    func setupActions() {
        pickMediaView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        pickMediaView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func nextTapped() {
        print("next tapped")
    }
    
}
