//
//  PickMediaViewModel.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/3.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

struct PickMediaViewModel {
    var allMedias: [PickMedia]
    var searchFilter: String?
    
    init(allMedias: [PickMedia]) {
        self.allMedias = allMedias
    }
    static let defaultViewModel = PickMediaViewModel(allMedias: [])
}

extension PickMediaViewModel {
    var medias: [PickMedia] {
        guard let searchText = searchFilter else { return allMedias }
        if searchText == "" {
            return allMedias
        } else {
            return allMedias.filter {
                $0.hashtags.contains { (hashtag) -> Bool in
                    hashtag.contains(searchText.lowercased())
                }
            }
        }
    }
}
