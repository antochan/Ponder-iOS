//
//  Poem.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

struct Poem {
    let id: String?
    let poemImage: UIImage
    let title: String?
    let poemContent: String
    let poemTags: [String]
    let comments: [Comment]
    let author: String
    let likes: Int
}

struct PoemCarouselData {
    let poems: [Poem]
}

struct PoemText {
    let title: String
    let poemContent: String
}
