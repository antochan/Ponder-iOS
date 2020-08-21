//
//  Constants.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//


import UIKit

public enum EmailSignupSteps: CaseIterable {
    case enterEmail
    case enterPassword
    case enterHandle
    
    var listTextType: ListTextType {
        switch self {
        case .enterEmail:
            return .email
        case .enterPassword:
            return .password
        case .enterHandle:
            return .username
        }
    }
}

public enum AccountPageType {
    case own
    case other
}

public enum AddViewConstants {
    static let poemPlaceholderText = "Start Writing"
    static let titlePlaceholderText = "Title"
    static let titleMaxCount: Int = 35
}

public enum HomeStackConstants {
    static let poemContentExpandStaticHeight: CGFloat = 161.5
    static let poemContentCommentStaticHeight: CGFloat = 165
    static let homeMultiplierStatic: CGFloat = 0.85
    static let poemContentHeightExpanded: CGFloat = UIScreen.main.bounds.height * 0.65
    static let dismissButtonHeight: CGFloat = 35
}

public enum HeroIds {
    static let poemTitleView = "PoemTitleView"
    static let poemContentView = "PoemContentView"
    static let poemHashtagView = "PoemHashtagView"
}

public enum HomeConstants {
    static let carouselHeightMultiplier: CGFloat = 0.65
    static let imageHeightMultiplier: CGFloat = 0.45
}

public enum HomeIconType: Int {
    case like
    case comments
    case more
}

public enum Lines {
    static let staticLine = 4
    static let multiLine = 0
}

public enum Page {
    static let homePageCap = 5
}

public enum Spacing {
    public static let zero: CGFloat = 0
    public static let four: CGFloat = 4
    public static let eight: CGFloat = 8
    public static let twelve: CGFloat = 12
    public static let sixteen: CGFloat = 16
    public static let twentyFour: CGFloat = 24
    public static let thirtyTwo: CGFloat = 32
    public static let fortyEight: CGFloat = 48
}

public struct CornerRadius {
    public enum Style {
        /// 12pt corner radius
        case large
        /// 6pt corner radius
        case small
        /// 3pt corner radius
        case tiny
        /// 0pt corner radius
        case none
        /// Calculcates the corner radius based on the one half of the `height` of the `bounds`
        case circular
        public func value(forBounds bounds: CGRect) -> CGFloat {
            switch self {
            case .large:
                return 12.0
            case .small:
                return 6.0
            case .tiny:
                return 3.0
            case .none:
                return 0.0
            case .circular:
                return bounds.height / 2.0
            }
        }
    }
    
    public let style: Style
    public let cornerMasks: CACornerMask
    public let rectCorners: UIRectCorner
    
    public init(style: Style, cornerMasks: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.style = style
        self.cornerMasks = cornerMasks
        rectCorners = UIRectCorner.make(withCornerMasks: cornerMasks)
    }
}

// MARK: - UIRectCorner

private extension UIRectCorner {
    static func make(withCornerMasks cornerMasks: CACornerMask) -> UIRectCorner {
        var rectCorners = UIRectCorner()
        
        if cornerMasks.contains(.layerMinXMinYCorner) {
            rectCorners.insert(.topLeft)
        }
        
        if cornerMasks.contains(.layerMaxXMinYCorner) {
            rectCorners.insert(.topRight)
        }
        
        if cornerMasks.contains(.layerMinXMaxYCorner) {
            rectCorners.insert(.bottomLeft)
        }
        
        if cornerMasks.contains(.layerMaxXMaxYCorner) {
            rectCorners.insert(.bottomRight)
        }
        
        return rectCorners
    }
}

public enum BorderWidth: CGFloat {
    case normal = 1.0
    case thin = 0.5
    case none = 0.0
}
