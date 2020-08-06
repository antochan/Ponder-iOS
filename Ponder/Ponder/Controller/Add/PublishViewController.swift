//
//  PublishViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/4.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    let publishView = PublishView()
    private let media: PickMedia
    private let poemContent: PoemText
    
    init(media: PickMedia, poemContent: PoemText) {
        self.media = media
        self.poemContent = poemContent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = publishView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        publishView.applyPublishView(poemContent: poemContent, poemMedia: media)
    }
    
    func setupActions() {
        publishView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        publishView.publishButton.addTarget(self, action: #selector(publishTapped), for: .touchUpInside)
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func publishTapped() {
        print("Publish Tapped")
    }

}
