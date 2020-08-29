//
//  LoginViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/28.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let authService: AuthService
    let loginView = LoginView()
    private var email = ""
    private var password = ""
    
    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(shouldEnableToolbar: false)
        configureActions()
    }
    
    func configureActions() {
        loginView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.emailListComponent.delegate = self
        loginView.passwordListComponent.delegate = self
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func loginTapped() {
        loginRequest()
    }
    
    func loginRequest() {
        authService.login(loginData: ["email": email, "password": password]) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let loginObject):
                guard let _ = loginObject.id else {
                    strongSelf.displayAlert(message: "\(loginObject.error ?? "")", title: "Invalid Login")
                    return
                }
                strongSelf.validateUserSessionCookes()
            case .failure(let error):
                strongSelf.displayAlert(message: error.localizedDescription)
            }
        }
    }
    
    func validateUserSessionCookes() {
        if HTTPCookieStorage.shared.cookies?.count == 2 {
            dismiss(animated: true)
        } else {
            displayAlert(message: "Something went wrong with storing your usersession cookie, Please try again!", title: "Oops")
        }
    }

}

//MARK: - ListTextDelegate

extension LoginViewController: ListTextDelegate {
    func enteredText(text: String, listTextType: ListTextType) {
        switch listTextType {
        case .email:
            email = text
        case .password:
            password = text
        default:
            return
        }
    }
}
