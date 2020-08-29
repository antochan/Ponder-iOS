//
//  UIView+Extensions.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import AudioToolbox
import IQKeyboardManagerSwift

public extension UIView {
    func apply(cornerRadius: CornerRadius) {
        layer.cornerRadius = cornerRadius.style.value(forBounds: bounds)
        layer.maskedCorners = cornerRadius.cornerMasks
    }
    
    func apply(borderWidth: BorderWidth) {
        layer.borderWidth = borderWidth.rawValue
    }
    
    func fadeOut(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.isHidden = true
        })
    }
    
    func fadeIn(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        isHidden = false
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 1
        }, completion: { finished in
            self.isHidden = false
        })
    }
    
    func createDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
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

extension UIViewController {
    func hideKeyboardWhenTappedAround(shouldEnableToolbar: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = shouldEnableToolbar
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// This function displays a UIAlertView string for a given `message: String`.
    ///
    /// - Warning: Make sure this is called on the main thread
    ///
    /// Usage:
    ///
    ///     displayAlert("Your Message Here)
    func displayAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        OKAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case selection
    case oldSchool
    
    public func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

extension String {
    func numberOfLines() -> Int {
        var count = 0
        self.enumerateLines { (self, _) in
            count += 1
        }
        return count
    }
}

extension UIButton {
    func makeEnabled(_ shouldEnable: Bool) {
        isEnabled = shouldEnable
        setTitleColor(shouldEnable ? .black : UIColor.AppColors.gray, for: .normal)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
