//
//  EmailSignupViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/19.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class EmailSignupViewController: UIViewController {
    let emailSignupView = EmailSignupView()
    var currentPage: Int = 1 {
        didSet {
            emailSignupView.updateView(step: currentPage, totalSteps: EmailSignupSteps.allCases.count)
        }
    }
    
    override func loadView() {
        super.loadView()
        view = emailSignupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(shouldEnableToolbar: true)
        emailSignupView.nextButton.makeEnabled(false)
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
            emailSignupView.nextButton.makeEnabled(true)
        }
        currentPage -= 1
    }
    
    @objc func nextTapped() {
        let indexPath = IndexPath(row: currentPage, section: 0)
        emailSignupView.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        emailSignupView.nextButton.makeEnabled(false)
        currentPage += 1
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
        print(listTextType)
        emailSignupView.nextButton.makeEnabled(true)
    }
}
