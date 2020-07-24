//
//  ButtonComponent.swift
//  Ponder
//
//  Created by Antonio Chan on 2020/7/23.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import CoreGraphics

public final class ButtonComponent: UIButton, Pressable {
    
    public enum Style {
        case primary
        case secondary
        case minimal(UIColor)
        
        fileprivate var verticalPadding: CGFloat {
            switch self {
            case .primary:
                return 12.5
            case .secondary:
                return 6.5
            case .minimal:
                return 5.5
            }
        }
        
        fileprivate var horizontalPadding: CGFloat {
            switch self {
            case .primary:
                return Spacing.thirtyTwo
            case .secondary:
                return Spacing.sixteen
            case .minimal:
                return Spacing.eight
            }
        }
        
    }
    
    public let configuration = PressableConfiguration(pressScale: .large)
    
    public var actions: Actions?
    
    private var style: Style = .primary {
        didSet {
            setNeedsLayout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        configureSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch style {
        case .primary, .secondary:
            apply(cornerRadius: CornerRadius(style: .circular))
        case .minimal:
            apply(cornerRadius: CornerRadius(style: .tiny))
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            set(isPressed: isHighlighted,
                animated: true)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.40
        }
    }
}

// MARK: - HeightCalculatingComponent
extension ButtonComponent: HeightCalculatingComponent {
    public struct ViewModel {
        public let style: Style
        public let text: String?
        public let icon: UIImage?
        public let backgroundColor: UIColor
        public let borderColor: UIColor
        public let textColor: UIColor
        
        public init(style: Style, text: String?, icon: UIImage? = nil, backgroundColor: UIColor, borderColor: UIColor, textColor: UIColor) {
            self.style = style
            self.text = text
            self.icon = icon
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.textColor = textColor
        }
    }
    
    public func prepareForReuse() {
        setImage(nil, for: .normal)
    }
    
    public func apply(viewModel: ButtonComponent.ViewModel) {
        setImage(viewModel.icon, for: .normal)
        setTitle(viewModel.text, for: .normal)
        
        let titlePadding = (viewModel.icon == nil) ? 0 : Constants.iconPadding
        titleEdgeInsets = UIEdgeInsets(top: 0, left: titlePadding, bottom: 0, right: -titlePadding)
        
        style = viewModel.style
        switch viewModel.style {
        case .primary:
            applyPrimary(hasTitle: viewModel.text != nil, hasImage: viewModel.icon != nil, backgroundColorPassed: viewModel.backgroundColor, titleColor: viewModel.textColor)
        case .secondary:
            applySecondary(hasTitle: viewModel.text != nil, hasImage: viewModel.icon != nil, borderColor: viewModel.borderColor, titleColor: viewModel.textColor)
        case .minimal(let color):
            applyMinimal(color: color, hasTitle: viewModel.text != nil, hasImage: viewModel.icon != nil)
        }
    }
    
    public static func height(forViewModel viewModel: ButtonComponent.ViewModel, width: CGFloat) -> CGFloat {
        let textHeight = Constants.font.lineHeight
        let padding = 2.0 * viewModel.style.verticalPadding
        return textHeight + padding
    }
}

// MARK: - SizeCalculatingComponent
extension ButtonComponent: SizeCalculatingComponent {
    public static func size(forViewModel viewModel: ButtonComponent.ViewModel) -> CGSize {
        let iconWidth: CGFloat
        let iconPadding: CGFloat
        if let icon = viewModel.icon {
            iconWidth = icon.size.width
            if viewModel.text != nil {
                iconPadding = Constants.iconPadding
            } else {
                iconPadding = 0.0
            }
        } else {
            iconWidth = 0.0
            iconPadding = 0.0
        }
        
        let textWidth: CGFloat
        if let text = viewModel.text {
            let attributes = [
                NSAttributedString.Key.font: Constants.font
            ]
            textWidth = NSAttributedString(string: text, attributes: attributes).singleLineWidth()
        } else {
            textWidth = 0.0
        }
        
        let horizontalPadding = viewModel.style.horizontalPadding * 2.0
        let width = iconWidth + iconPadding + textWidth + horizontalPadding
        let height = self.height(forViewModel: viewModel, width: width)
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Private
private extension ButtonComponent {
    
    enum Constants {
        static let font = UIFont.georgia(size: 14)
        static let iconPadding: CGFloat = Spacing.eight
    }
    
    func configureSubviews() {
        layer.masksToBounds = true
        titleLabel?.lineBreakMode = .byTruncatingTail
        titleLabel?.font = Constants.font
        addTarget(self, action: #selector(didSelectButton), for: .primaryActionTriggered)
    }
    
    func applyPrimary(hasTitle: Bool, hasImage: Bool, backgroundColorPassed: UIColor, titleColor: UIColor) {
        backgroundColor = backgroundColorPassed
        apply(borderWidth: .none)
        layer.borderColor = nil
        setTitleColor(titleColor, for: .normal)
        setContentInsets(hasTitle: hasTitle,
                         hasImage: hasImage,
                         insets: UIEdgeInsets(top: Style.primary.verticalPadding,
                                              left: Style.primary.horizontalPadding,
                                              bottom: Style.primary.verticalPadding,
                                              right: Style.primary.horizontalPadding))
    }
    
    func applySecondary(hasTitle: Bool, hasImage: Bool, borderColor: UIColor, titleColor: UIColor) {
        backgroundColor = .clear
        apply(borderWidth: .normal)
        layer.borderColor = borderColor.cgColor
        setTitleColor(titleColor, for: .normal)
        setContentInsets(hasTitle: hasTitle,
                         hasImage: hasImage,
                         insets: UIEdgeInsets(top: Style.secondary.verticalPadding,
                                              left: Style.secondary.horizontalPadding,
                                              bottom: Style.secondary.verticalPadding,
                                              right: Style.secondary.horizontalPadding))
    }
    
    func applyMinimal(color: UIColor, hasTitle: Bool, hasImage: Bool) {
        backgroundColor = .clear
        apply(borderWidth: .none)
        layer.borderColor = nil
        setTitleColor(color, for: .normal)
        imageView?.tintColor = color
        setContentInsets(hasTitle: hasTitle,
                         hasImage: hasImage,
                         insets: UIEdgeInsets(top: style.verticalPadding,
                                              left: style.horizontalPadding,
                                              bottom: style.verticalPadding,
                                              right: style.horizontalPadding))
    }
    
    func setContentInsets(hasTitle: Bool, hasImage: Bool, insets: UIEdgeInsets) {
        var modifiedInsets = insets
        switch (hasTitle, hasImage) {
        case (true, true):
            modifiedInsets.right += Constants.iconPadding
        default:
            break
        }
        contentEdgeInsets = modifiedInsets
    }
    
    @objc func didSelectButton() {
        actions?(.buttonAction)
    }
}

//MARK: - Actionable
extension ButtonComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case buttonAction
    }
}
