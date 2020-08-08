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
    
    private var isAdding: Bool = false {
        didSet {
            publishView.applyAddHashtag(isAdding: isAdding)
        }
    }
    
    private var hashtags: [String] = [] {
        didSet {
            publishView.addHashtags(hashtags: hashtags)
        }
    }
    
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
        hideKeyboardWhenTappedAround(shouldEnableToolbar: false)
        setupActions()
        publishView.delegate = self
        publishView.applyPublishView(poemContent: poemContent, poemMedia: media)
        publishView.applyAddHashtag(isAdding: isAdding)
    }
    
    func setupActions() {
        publishView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        publishView.publishButton.addTarget(self, action: #selector(publishTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(readMoreTapped))
        publishView.readMoreLabel.addGestureRecognizer(tap)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeGesture.direction = [.up]
        publishView.addGestureRecognizer(swipeGesture)
        publishView.hashtagTextField.delegate = self
        publishView.addHashtagButton.addTarget(self, action: #selector(addHastagTapped), for: .touchUpInside)
        publishView.hashtagTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                               for: .editingChanged)
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
    @objc func publishTapped() {
        print("Publish Tapped")
    }
    
    @objc func readMoreTapped() {
        displayExpand()
    }
    
    @objc func addHastagTapped() {
        isAdding.toggle()
    }
    
    @objc func swipeUp() {
        if poemContent.poemContent.numberOfLines() > Lines.staticLine {
            Vibration.light.vibrate()
            displayExpand()
        }
    }
    
    func displayExpand() {
        let homeExpandViewController = HomeExpandViewController(poem: Poem(id: "0",
                                                                           poemImage: media.mediaImage,
                                                                           title: poemContent.title,
                                                                           poemContent: poemContent.poemContent,
                                                                           poemTags: [],
                                                                           comments: [],
                                                                           author: "test",
                                                                           likes: 0))
        homeExpandViewController.modalPresentationStyle = .fullScreen
        homeExpandViewController.isHeroEnabled = true
        present(homeExpandViewController, animated: true) {
            homeExpandViewController.isViewPresented = true
        }
    }
}

//MARK: - TextView Delegate

extension PublishViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isAdding.toggle()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "#"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        isAdding = false
        guard let hashtag = textField.text else { return true }
        if hashtag != "#" && hashtag != "" && !hashtags.contains(hashtag) {
            hashtags.append(hashtag)
        }
        return true
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text == "" {
                textField.text = "#"
            }
        }
    }
}

//MARK: - PublishViewDelegate

extension PublishViewController: PublishViewDelegate {
    func removeHashtag(hashtag: String) {
        hashtags = hashtags.filter { $0 != hashtag }
    }
}
