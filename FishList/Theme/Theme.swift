//
//  Theme.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 26.02.2024.
//

import UIKit

class Theme {
    ///Top Offset 50
    static let topOffset50 = 50
    ///stackView Spacing 5
    static let spacing = 5.0
    ///Button Corner Radius 25
    static let buttonCornerRadius = 25.0
    ///Top offset 10
    static let topOffset10 = 10
    ///Top offset 25
    static let topOffset25 = 25
    ///layerBorderWidth 1.0
    static let layerBorderWidth = 1.0
    ///layerCornerRadius 10
    static let layerCornerRadius = 10.0
    ///FontTitleBold 50
    static let titleFontBold = UIFont.boldTitleFont()
    /// Button Tittle Font
    static let buttonTittleFont = UIFont.buttonTitleFont()
    ///FontBodyBold 20
    static let bodyFontBold = UIFont.boldBodyFont()
    /// offset 30
    static let leadingOffset = 30
    /// offset 30
    static let topWelcomeTextOffset = 30
    ///0.3
    static let imageViewHeightMultipliedBy = 0.3
    ///imageView cornerRadius 50
    static let imageViewCorerRadius = 50
    ///TextField Size 50
    static let textFieldSize = 50
    ///Email Top Offset 25
    static let emailTopOffset = 25
    ///Password button offset -40
    static let passWordButtonOffset = -40
    /// Start Color white
    static let startColor = UIColor.white
    /// End Color orange
    static let endColor = UIColor.systemOrange
    ///GradientLayerColor
    static func gradientLayerColor(startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        // Başlangıç rengi (üst kısım)
        let startColor = startColor.cgColor
        // Bitiş rengi (alt kısım)
        let endColor = endColor.cgColor
        // Renk tonlarını belirle
        gradientLayer.colors = [startColor, endColor]
        // Renk tonlarının geçişini belirle (üstten alta doğru)
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    static func leftPaddingView(textFieldHeight: CGFloat ) -> UIView {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textFieldHeight ))
        return leftPaddingView
    }
    
    static func maskLayer(imageView: UIImageView) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: imageView.bounds.width, height: imageView.bounds.height), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 50, height: 0)).cgPath
        return maskLayer
    }
}


extension UIFont {
    static func boldTitleFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 50)
    }
    static func boldBodyFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    static func buttonTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
}
