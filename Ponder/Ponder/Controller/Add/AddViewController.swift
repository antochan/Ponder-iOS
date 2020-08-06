//
//  AddViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/22.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    let addView = AddView()
    
    override func loadView() {
        super.loadView()
        view = addView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupActions()
    }
    
    func setupActions() {
        addView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        addView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc func nextTapped() {
        if addView.poemTextField.text == "Start Writing" || addView.poemTextField.text == "" {
            displayAlert(message: "Please make sure to type something", title: "Oops!")
        } else {
            var titleText = ""
            if addView.titleTextField.textColor != UIColor.AppColors.lightGray {
                titleText = addView.titleTextField.text
            }
            let pickMediaVC = PickMediaViewController(poemText: PoemText(title: titleText, poemContent: addView.poemTextField.text))
            pickMediaVC.isHeroEnabled = true
            pickMediaVC.modalPresentationStyle = .fullScreen
            present(pickMediaVC, animated: true)
        }
    }

}
