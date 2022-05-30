//
//  Font.swift
//  Breathy
//
//  Created by Andrei Olteanu on 28.05.2022.
//

import UIKit
import SwiftUI

private struct FontFamily {
    
    enum Inter: String, FontConvertible {
        case regular  = "Inter-Regular"
        case medium   = "Inter-Medium"
        case semiBold = "Inter-SemiBold"
        case bold     = "Inter-Bold"
    }
}

private struct Font {
    
    static func regular(size: CGFloat) -> UIFont {
        FontFamily.Inter.regular.font(size: size)
    }

    static func medium(size: CGFloat) -> UIFont {
        FontFamily.Inter.medium.font(size: size)
    }

    static func semiBold(size: CGFloat) -> UIFont {
        FontFamily.Inter.semiBold.font(size: size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        FontFamily.Inter.bold.font(size: size)
    }
}

private protocol FontConvertible {
    func font(size: CGFloat) -> UIFont
}

private extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    
    func font(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: rawValue, size: size) else {
            fatalError("\(rawValue) font is not installed, make sure it is added in Info.plist.")
        }

        return font
    }
}

// MARK: - Fonts

extension UIFont {
    /// 26
    static let h1Regular = Font.regular(size: 26)
    /// 26
    static let h1Medium = Font.medium(size: 26)
    /// 26
    static let h1SemiBold = Font.semiBold(size: 26)
    /// 26
    static let h1Bold = Font.bold(size: 26)

    /// 18
    static let bodyRegular = Font.regular(size: 18)
    /// 18
    static let bodyMedium = Font.medium(size: 18)
    /// 18
    static let bodySemiBold = Font.semiBold(size: 18)
    /// 18
    static let bodyBold = Font.bold(size: 18)

    /// 14
    static let secondaryTextRegular = Font.regular(size: 14)
    /// 14
    static let secondaryTextMedium = Font.medium(size: 14)
    /// 14
    static let secondaryTextSemiBold = Font.semiBold(size: 14)
    /// 14
    static let secondaryTextBold = Font.bold(size: 14)

    /// 18
    static let tertiaryTextRegular = Font.regular(size: 12)
    /// 18
    static let tertiaryTextMedium = Font.medium(size: 12)
    /// 18
    static let tertiaryTextSemiBold = Font.semiBold(size: 12)
    /// 18
    static let tertiaryTextBold = Font.bold(size: 12)
}

extension SwiftUI.Font {

    init(_ uiFont: UIFont) {
        self = SwiftUI.Font(uiFont as CTFont)
    }
}
