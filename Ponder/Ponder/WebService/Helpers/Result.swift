//
//  Result.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/8/25.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
