//
//  CommonExtensions.swift
//  WeatherDemo
//
//  Created by Mohammed Rizwan on 10/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
extension UIView {
func addViewBorderAndCornerRadius(borderWidth:CGFloat,borderColour:UIColor,cornerRadiusValue:CGFloat) {
    layer.cornerRadius = cornerRadiusValue
    layer.borderWidth = borderWidth
    layer.borderColor = borderColour.cgColor
}
func addViewCornerRadius(cornerRadiusValue:CGFloat) {
    layer.cornerRadius = cornerRadiusValue
}
func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
}
func addShadow(shadowOffset: CGSize,shadowRadius: CGFloat,shadowOpacity: Float) {
    layer.masksToBounds = false
    layer.shadowOffset = shadowOffset
    layer.shadowRadius = shadowRadius
    layer.shadowOpacity = shadowOpacity
}
func addShadow() {
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 1.5)
    layer.shadowRadius = 2
    layer.shadowOpacity = 0.3
}
func addShadowMask() {
    layer.masksToBounds = true
    layer.shadowOffset = CGSize(width: 0, height: 1.5)
    layer.shadowRadius = 2
    layer.shadowOpacity = 0.3
    }
}

extension UIColor {
    class func appThemeColor() -> UIColor {
        return UIColor(named: "AppThemeColor") ?? UIColor(hex: "49A7DC")
    }
    
    class func appDarkThemeColor() -> UIColor {
        return UIColor(named: "AppDarkThemeColor") ?? UIColor(hex: "522ABC")
    }
    
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}


extension Double {
    func getCelsiusToFahrenheit() -> Double {
        return ((self*1.8) + 32.0)
    }
    
    func getFahrenheitToCelsius() -> Double {
        return ((self-32) / 1.8)
    }
}
