//
//  UIView+Extensions.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

public extension UIView {
    func apply(cornerRadius: CornerRadius) {
        layer.cornerRadius = cornerRadius.style.value(forBounds: bounds)
        layer.maskedCorners = cornerRadius.cornerMasks
    }
    
    func apply(borderWidth: BorderWidth) {
        layer.borderWidth = borderWidth.rawValue
    }
}

public extension NSAttributedString {
    func singleLineWidth() -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let textContainer = NSTextContainer(size: size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = .byTruncatingTail
        textContainer.maximumNumberOfLines = 1
        
        let layoutManager = NSLayoutManager()
        layoutManager.usesFontLeading = false
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: self)
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.ensureLayout(for: textContainer)
        
        let usedRect = layoutManager.usedRect(for: textContainer)
        let width = ceil(usedRect.width)
        
        return width
    }
}

extension UIStackView {
    func addArrangedSubviews(_ arrangedViews: UIView...) {
        arrangedViews.forEach { addArrangedSubview($0) }
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension Int {
    func correctPageIndex(perPage: Int) -> Int {
        if self < perPage { return self }
        if self % perPage == 0 { return perPage }
        return self % perPage
    }
    
    func correctTotalPage(perPage: Int, currentPage: Int, totalPage: Int) -> Int {
        var nonFullPageValues = [Int]()
        var nonFullPageCount = 0
        for i in 0...perPage {
            if (totalPage - i) % perPage == 0 {
                break
            } else {
                nonFullPageValues.append(totalPage - i)
                nonFullPageCount += 1
            }
        }
        if nonFullPageValues.contains(currentPage) {
            return nonFullPageCount
        } else {
            return perPage
        }
    }
}
