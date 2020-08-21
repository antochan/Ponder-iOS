//
//  Fonts.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIFont {
    class func georgia(size: CGFloat) -> UIFont {
        return UIFont(name: "Georgia", size: size)!
    }
    
    class func georgiaBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Georgia-Bold", size: size)!
    }
    
    class func main(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func mainItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    class func mainBold(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func mainMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}
