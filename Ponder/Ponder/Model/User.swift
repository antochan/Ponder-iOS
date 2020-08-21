//
//  User.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

struct User {
    let id: String
    let profilePicture: UIImage
    let username: String
    let bio: String?
    let followerCount: Int
    let followingCount: Int
}

struct Comment {
    let user: User
    let comment: String
}
