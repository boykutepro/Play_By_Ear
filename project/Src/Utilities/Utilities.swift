//
//  Utilities.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
//import KeychainSwift
//import SkyFloatingLabelTextField

class Utilities {
    
    // Avoid init
    private init() {
        
    }
    
    // MARK: - Create Border , CornerRadius & Shadow for Views
    class func createBorder(for views: UIView..., color: UIColor, width: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.borderWidth = width
            view.layer.borderColor = color.cgColor
        }
    }
    
    class func createCornerRadius(for views: UIView..., radius: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.cornerRadius = radius
        }
    }
    
    class func createCornerLabel(for views: UILabel..., radius: CGFloat) {
             // create border for many views or a view
             for view in views {
                 view.layer.cornerRadius = radius
              view.layer.masksToBounds = true
                 
             }
         }
      
    
    
    class func createCornerImage(for views: UIImageView..., radius: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.cornerRadius = radius
            view.clipsToBounds = true
            
        }
    }
    
    class func createShadow(for views: UIView...,
        opacity: Float = 0.5,
        radius: CGFloat = 3.0,
        offSet: CGSize = CGSize.zero,
        cgColor: CGColor = UIColor.gray.cgColor) {
        // Create shadow for many views or a view
        for view in views {
            view.layer.shadowColor = cgColor
            view.layer.shadowRadius = radius
            view.layer.shadowOffset = offSet
            view.layer.shadowOpacity = opacity
        }
    }
  
  
    
    //MARK: - Animation
    class func animate(duration: TimeInterval , damping: CGFloat, velocity: CGFloat, fromValue: () -> Void, toValue: @escaping () -> Void) {
        // Set begin value animation
        fromValue()
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .allowUserInteraction,
                       animations: {
                        // Set end value animation
                        toValue()
        },
                       completion: nil)
    }
    
    class func animateCompletion(duration: TimeInterval , damping: CGFloat, velocity: CGFloat, animation: @escaping () -> Void, completion: (() -> ())?) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .allowUserInteraction,
                       animations: {
                        // Handle animation
                        animation()
        }, completion: { (_) in
            // Check completion is availabel
            if completion != nil {
                completion!()
            }
        })
    }    
    
    //MARK: - Get Device ID
//    class func  getDeviceID() -> String {
//        // Get device ID from the keychain
//        let keychain = KeychainSwift()
//        let appKey = "appName:\(Bundle.main.bundleIdentifier!)"
//        var deviceID = keychain.get(appKey)
//        
//        // If deviceID has not been stored in keychain, save it
//        if deviceID == nil {
//            deviceID = UIDevice.current.identifierForVendor!.uuidString
//            keychain.set(deviceID!, forKey: appKey)
//        }
//        return deviceID!
//    }
    
    //MARK: - Save & Get Custom Class To UserDefault
    //TODO: User
//    class func saveUser(_ user: User) {
//        let userDict = user.encode()
//        let userData = NSKeyedArchiver.archivedData(withRootObject: userDict)
//        UserDefaults.standard.set(userData, forKey: UserDefaultsKey.currentUser)
//    }
//    
//    class func getUser() -> User? {
//        if let userData = UserDefaults.standard.data(forKey: UserDefaultsKey.currentUser) {
//            let userDict = NSKeyedUnarchiver.unarchiveObject(with: userData) as! Dictionary<String, AnyObject>
//            let user = User(dictionary: userDict)
//            return user
//        } else {
//            return nil
//        }
//    }
    
    
    //MARK: - Configure SkyFloatingLabelTextField
//    //TODO: SkyFloatingLabelTextField
//    class func configureTextField(_ tupples: (textField: SkyFloatingLabelTextField, title: String, placeholder: String)..., colorHighlight: UIColor, colorNormal: UIColor, textColor: UIColor) {
//        
//        for tupple in tupples {
//            // Configure
//            tupple.textField.title = tupple.title
//            tupple.textField.placeholder = tupple.placeholder
//            tupple.textField.placeholderColor = colorNormal
//            tupple.textField.tintColor = colorNormal
//            tupple.textField.textColor = textColor
//            
//            // Set highlight color when selected text field
//            highlightedTextField(textField: tupple.textField, color: colorHighlight)
//        }
//    }
//    
//    class func configureTextField2(_ tupples: (textField: SkyFloatingLabelTextField, title: String, placeholder: String)..., colorHighlight: UIColor, colorNormal: UIColor, textColor: UIColor) {
//        
//        for tupple in tupples {
//            // Configure
//            tupple.textField.placeholder = tupple.placeholder
//            tupple.textField.title = tupple.title
//            tupple.textField.textAlignment = .center
//            tupple.textField.placeholderColor = colorNormal
//            tupple.textField.titleColor = colorNormal
//            tupple.textField.lineColor = colorNormal
//            tupple.textField.tintColor = colorNormal
//            tupple.textField.textColor = textColor
//            
//            // Set highlight color when selected text field
//            highlightedTextField(textField: tupple.textField, color: colorHighlight)
//        }
//    }
//    
//    class func highlightedTextField(textField: SkyFloatingLabelTextField, color: UIColor) {
//        textField.selectedTitleColor = color
//        textField.selectedLineColor = color
//    }
    
    //MARK: - Validate Value
    func getIntValue(object: AnyObject?, errorValue: Int, didError: (()-> Void)? = nil) -> Int {
        if object == nil || object is NSNull {
            return errorValue
        }
        
        if object is String {
            if let int = Int(object as! String) {
                return int
            }
        }
        
        if object is NSNumber {
            return object as! Int
        }
        
        if object is Int {
            return object as! Int
        }
        
        didError?()
        return errorValue
    }
    
    class func openUrl(urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return
        }
        UIApplication.shared.openURL(url)
    }

    
    class func validateEmail(_ email:String) -> Bool {
        let emailRegEx = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*\\s+&lt;(\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,6})&gt;$|^(\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,6})$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isEmail = emailTest.evaluate(with: email)
        // Validate email
        if !validateInfomation(email, minCharacter: 6, maxCharacter: 50) ||
            !isEmail {
            return false
        } else {
            return true
        }
    }
    
    
    class func validateInfomation(_ text: String, minCharacter: Int = 2, maxCharacter: Int = 50) -> Bool {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
           text.trimmingCharacters(in: .whitespaces).characters.count < minCharacter ||
           text.trimmingCharacters(in: .whitespaces).characters.count > maxCharacter {
            return false
        } else {
            return true
        }
    }

  
}
