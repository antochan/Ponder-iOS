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
    
    override func loadView() {
        super.loadView()
        view = emailSignupView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emailSignupView.updateStepLabel(step: 1, totalSteps: EmailSignupSteps.allCases.count)
        setupCollectionView()
        configureActions()
    }
    
    func setupCollectionView() {
        emailSignupView.collectionView.keyboardDismissMode = .onDrag
        emailSignupView.collectionView.register(ComponentCollectionViewCell<ListTextComponent>.self, forCellWithReuseIdentifier: "SignupCell")
        emailSignupView.collectionView.delegate = self
        emailSignupView.collectionView.dataSource = self
    }

    func configureActions() {
        emailSignupView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
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
        emailSignupView.updateStepLabel(step: page + 1, totalSteps: EmailSignupSteps.allCases.count)
    }
}
