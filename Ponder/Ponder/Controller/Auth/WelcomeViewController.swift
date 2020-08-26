//
//  WelcomeViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/18.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Hero

class WelcomeViewController: UIViewController {
    let welcomeView = WelcomeView()
    
    override func loadView() {
        super.loadView()
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
    }
    
    func configureActions() {
        welcomeView.signUpWithEmail.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.presentEmailSignup()
        }
    }
    
    func presentEmailSignup() {
        let emailSignupViewController = EmailSignupViewController(authService: AuthService())
        emailSignupViewController.isHeroEnabled = true
        emailSignupViewController.modalPresentationStyle = .fullScreen
        present(emailSignupViewController, animated: true)
    }
}
