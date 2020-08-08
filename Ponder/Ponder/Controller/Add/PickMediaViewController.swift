//
//  PickMediaViewController.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/2.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PickMediaViewController: UIViewController {
    let pickMediaView = PickMediaView()
    let poemText: PoemText
    
    private let mockPickMediaData = [PickMedia(mediaImage: #imageLiteral(resourceName: "camera"), hashtags: ["#camera", "#aeshetics", "#photo", "#photography", "#shutter", "#stock"]),
                                     PickMedia(mediaImage: #imageLiteral(resourceName: "earphones"), hashtags: ["#idea", "#music", "#covid-19", "#earbuds", "#wires", "#unplugged", "#lightbulb"]),
                                     PickMedia(mediaImage: #imageLiteral(resourceName: "girl_back"), hashtags: ["#womensrights", "#feminism", "#equality", "#nudity", "#artwork"])]
    
    private var viewModel = PickMediaViewModel.defaultViewModel {
        didSet {
            pickMediaView.tableView.reloadData()
        }
    }
    
    init(poemText: PoemText) {
        self.poemText = poemText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = pickMediaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround(shouldEnableToolbar: true)
        setupActions()
        setupTableView()
        pickMediaView.searchBar.delegate = self
        viewModel = PickMediaViewModel(allMedias: mockPickMediaData)
    }
    
    func setupActions() {
        pickMediaView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    func setupTableView() {
        pickMediaView.tableView.delegate = self
        pickMediaView.tableView.dataSource = self
        pickMediaView.tableView.register(ComponentTableViewCell<PickMediaComponent>.self, forCellReuseIdentifier: "PickMediaCell")
    }
    
    @objc func backTapped() {
        dismiss(animated: true)
    }
    
}

//MARK: - UITableView Delegate & DataSource

extension PickMediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.medias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickMediaCell", for: indexPath) as! ComponentTableViewCell<PickMediaComponent>
        let pickMedia = viewModel.medias[indexPath.row]
        let cellVM = ComponentTableViewCell<PickMediaComponent>.ViewModel(componentViewModel: PickMediaComponent.ViewModel(pickMedia: pickMedia))
        cell.apply(viewModel: cellVM)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let publishViewController = PublishViewController(media: viewModel.medias[indexPath.row], poemContent: poemText)
        publishViewController.isHeroEnabled = true
        publishViewController.modalPresentationStyle = .fullScreen
        present(publishViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension PickMediaViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchFilter = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""  {
            viewModel.searchFilter = nil
        }
    }
}
