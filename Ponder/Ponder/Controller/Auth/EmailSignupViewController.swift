//
//  EmailSignupViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/19.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class EmailSignupViewController: UIViewController {
    private let authService: AuthService
    private let emailSignupView = EmailSignupView()
    private var email = ""
    private var password = ""
    private var username = ""
    
    private var currentPage: Int = 1 {
        didSet {
            emailSignupView.updateView(step: currentPage, totalSteps: EmailSignupSteps.allCases.count)
        }
    }
    
    
    
    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = emailSignupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(shouldEnableToolbar: false)
        configureNextButton()
        emailSignupView.updateView(step: currentPage, totalSteps: EmailSignupSteps.allCases.count)
        setupCollectionView()
        configureActions()
    }
    
    func setupCollectionView() {
        emailSignupView.collectionView.register(ComponentCollectionViewCell<ListTextComponent>.self, forCellWithReuseIdentifier: "SignupCell")
        emailSignupView.collectionView.delegate = self
        emailSignupView.collectionView.dataSource = self
    }
    
    func configureActions() {
        emailSignupView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        emailSignupView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func backTapped() {
        if currentPage == EmailSignupSteps.enterEmail.rawValue {
            dismiss(animated: true)
        } else {
            let indexPath = IndexPath(row: currentPage - 2, section: 0)
            emailSignupView.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
            currentPage -= 1
        }
        configureNextButton()
    }
    
    @objc func nextTapped() {
        // Email Validation
        if currentPage == EmailSignupSteps.enterEmail.rawValue {
            validateEmail()
        }
            // Password Validation
        else if currentPage == EmailSignupSteps.enterPassword.rawValue {
            validatePassword()
        }
            // Username Validation
        else if currentPage == EmailSignupSteps.allCases.count {
            validateUsername()
        }
            // Unknown Case
        else {
            return
        }
    }
    
    func continueToNextStep() {
        let indexPath = IndexPath(row: currentPage, section: 0)
        emailSignupView.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        currentPage += 1
        configureNextButton()
    }
    
    func configureNextButton() {
        if currentPage == 1 {
            emailSignupView.nextButton.makeEnabled(email != "")
        } else if currentPage == 2 {
            emailSignupView.nextButton.makeEnabled(password != "")
        } else {
            emailSignupView.nextButton.makeEnabled(username != "")
        }
    }
    
    func validateEmail() {
        if email.isValidEmail() {
            continueToNextStep()
        } else {
            displayAlert(message: "Badly formatted email. Make sure to enter a valid email!", title: "Invalid Email")
        }
    }
    
    func validatePassword() {
        if password.count > 5 {
            continueToNextStep()
        } else {
            displayAlert(message: "Please make sure your password is at least 5 characters long.", title: "Invalid Password")
        }
    }
    
    func validateUsername() {
        if username.count > 20 {
            displayAlert(message: "Please make sure your username is less than 20 characters long.", title: "Invalid Username")
        } else {
            signupRequest()
        }
    }
    
    func signupRequest() {
        authService.signUp(signInData: ["email": email, "password": password, "username": username]) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let signupObject):
                guard let _ = signupObject.id else {
                    strongSelf.displayAlert(message: "\(signupObject.error ?? ErrorConstants.unknownErrorText): \(signupObject.fields?[0] ?? ErrorConstants.unknown)", title: ErrorConstants.invalidSignup)
                    return
                }
                strongSelf.loginRequest()
            case .failure(let error):
                strongSelf.displayAlert(message: error.localizedDescription)
            }
        }
    }
    
    func loginRequest() {
        authService.login(loginData: ["email": email, "password": password]) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let loginObject):
                guard let _ = loginObject.id else {
                    strongSelf.displayAlert(message: "\(loginObject.error ?? ErrorConstants.unknownErrorText)", title: ErrorConstants.invalidLogin)
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
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        } else {
            displayAlert(message: "Something went wrong with storing your usersession cookie, Please try again!", title: "Oops")
        }
    }
}

//MARK: - UICollectionView Delegate & DataSource

extension EmailSignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmailSignupSteps.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupCell", for: indexPath) as! ComponentCollectionViewCell<ListTextComponent>
        let cellVM = ComponentCollectionViewCell<ListTextComponent>.ViewModel(componentViewModel: ListTextComponent.ViewModel(listTextType: EmailSignupSteps.allCases[indexPath.row].listTextType, listTextStyle: .bothDividers))
        cell.apply(viewModel: cellVM)
        cell.component.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = 45
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        currentPage = page + 1
    }
}

//MARK: - ListTextDelegate

extension EmailSignupViewController: ListTextDelegate {
    func enteredText(text: String, listTextType: ListTextType) {
        switch listTextType {
        case .email:
            email = text
        case .password:
            password = text
        case .username:
            username = text
        default:
            return
        }
        configureNextButton()
    }
}
