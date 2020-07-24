//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
}

extension UIView {
    
    func addTapGesture(callBack: Selector) -> Void {
        let tap = UITapGestureRecognizer.init(target: self, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,parent:AnyObject?) -> Void {
        let tap = UITapGestureRecognizer.init(target: parent, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,parent:AnyObject?,delegate:UIGestureRecognizerDelegate) -> Void {
        let tap = UITapGestureRecognizer.init(target: parent, action: callBack)
        tap.delegate = delegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,viewController:UIViewController) -> Void {
        let tap = UITapGestureRecognizer.init(target: viewController, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.cornerRadius = 16
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        //layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func layerGradient(colors: [CGColor]) {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint.init(x: 0, y: 0)
        layer.colors = colors
        self.layer.insertSublayer(layer, at: 0)
    }

}


//MARK: - UIButton
extension UIButton {
    func getUniversalSize() {
        if let label = self.titleLabel {
            let fontName = label.font.fontName
            var size = label.font.pointSize
            if CurrentDevice.isIpadBig {
                size += 10
            } else if CurrentDevice.isIpad {
                size += 8
            } else if CurrentDevice.isIphone7Plus {
                size += 2
            } else if CurrentDevice.isIphone7 {
                size += 1
            }
            label.font = UIFont.init(name: fontName, size: size)!
        }
    }
}

//MARK: - UILabel
extension UILabel {
    func getUniversalSize() {
        let fontName = self.font.fontName
        var size = self.font.pointSize
        if CurrentDevice.isIpadBig {
            size += 6
        } else if CurrentDevice.isIpad {
            size += 4
        } else if CurrentDevice.isIphone7Plus {
            size += 2
        } else if CurrentDevice.isIphone7 {
            size += 1
        }
        self.font = UIFont.init(name: fontName, size: size)!
    }
}

//MARK: - UITextView
extension UITextView {
    func getUniversalSize() {
        let fontName = self.font!.fontName
        var size = self.font!.pointSize
        if CurrentDevice.isIpadBig {
            size += 6
        } else if CurrentDevice.isIpad {
            size += 4
        } else if CurrentDevice.isIphone7Plus {
            size += 2
        } else if CurrentDevice.isIphone7 {
            size += 1
        }
        self.font = UIFont.init(name: fontName, size: size)!
    }
}

//MARK: - UITextField
extension UITextField {
    func getUniversalSize() {
        let fontName = self.font!.fontName
        var size = self.font!.pointSize
        if CurrentDevice.isIpadBig {
            size += 6
        } else if CurrentDevice.isIpad {
            size += 4
        } else if CurrentDevice.isIphone7Plus {
            size += 2
        } else if CurrentDevice.isIphone7 {
            size += 1
        }
        self.font = UIFont.init(name: fontName, size: size)!
    }
}

extension UITextField {
    
    func changePlacehoderColor(_ color: UIColor) {
       // self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
    }
}

extension UIView {
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

