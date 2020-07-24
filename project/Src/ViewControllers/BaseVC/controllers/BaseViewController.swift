//
//  BaseViewController.swift
//
//
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Properties
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getNavBarSize()
        listenerNotificationForSettings()
        view.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
        // Do any additional setup after loading the view.
    }
    
     func setStatusBarColor()  {
            if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
                statusbarView.backgroundColor =  UIColor.colorWithHexString(Colors.primaryColor)
                view.addSubview(statusbarView)
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor =  UIColor.colorWithHexString(Colors.primaryColor)
                view.addSubview(statusBar!)
            }
        }
    
    //TODO: Custom Alert
    func showAlert(title: String?, message: String,
                   btnLeft: String?, actionLeft: (() -> ())?,
                   btnRight: String?, actionRight: (() -> ())? ) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        // Check title left is availabel
        if let titleLeft = btnLeft {
            let leftAction = UIAlertAction(title: titleLeft, style: .default) { (_) in
                // Check action left is availabel
                if actionLeft != nil {
                    actionLeft!()
                }
                
            }
            // Add action
            alert.addAction(leftAction)
        }
        // Check title right is availabel
        if let titleRight = btnRight {
            let rightAction = UIAlertAction(title: titleRight, style: .default) { (_) in
                // Check action right is availabel
                if actionRight != nil {
                    actionRight!()
                }
            }
            // Add action
            alert.addAction(rightAction)
        }
        
        // Set attribute string for message of UIAlertcontroller
        alert.setValue(createAttribute(message: message), forKey: "attributedMessage")
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func showAlertNormal(title: String, message: String) {
        self.showAlert(title: title, message: message,
                       btnLeft: nil, actionLeft: nil,
                       btnRight: "OK", actionRight: nil)
    }
    
   
    
    func showAlertInputText(title: String?, message: String?, placeHoder: String, keyboardType: UIKeyboardType, titleRight: String, actionRight: @escaping ((_ text: String) -> ())) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: nil)
        let rightAction = UIAlertAction(title: titleRight, style: .default) { (_) in
            let text = alert.textFields![0].text!
            actionRight(text)
        }
        alert.addAction(cancelAction)
        alert.addAction(rightAction)
        // Add textfield to alert controller
        alert.addTextField { (textfield) in
            // Configure textfield
            textfield.placeholder = placeHoder
            textfield.keyboardType = keyboardType
            textfield.clearButtonMode = .whileEditing
        }
        // Check message have value
        if message != nil {
            // Set attribute string for message of UIAlertcontroller
            alert.setValue(createAttribute(message: message!), forKey: "attributedMessage")
        }
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createAttribute(message: String) -> NSAttributedString {
        // Create AttributeString
        let customMessage = message
        let attributes:[String : AnyObject] = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "Helvetica Neue", size: 13)!]
        let attributeMessage = NSAttributedString(string: customMessage as String, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
        return attributeMessage
    }
    
    
    //TODO: Show Action Sheet Select Photo
    func showSelectPhoto(photoPicker: UIImagePickerController, in viewController: UIViewController, sourceView: UIView) {
        // Create Action Open Camera
        let openCamera = UIAlertAction(title: "Take Photo by Camera",
                                       style: .default,
                                       handler: { (_) in
                                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                            photoPicker.sourceType = .camera
                                            viewController.present(photoPicker, animated: true, completion: nil)
                                        } else {
                                            self.showAlertNormal(title: "ERROR", message: "Not found camera !")
                                        }
        })
        // Create Action Open Photo Library
        let openPhotoLibrary = UIAlertAction(title: "Add from Gallery",
                                             style: .default,
                                             handler: { (_) in
                                                photoPicker.sourceType = .photoLibrary
                                                viewController.present(photoPicker, animated: true, completion: nil)
        })
        // Create Action Cancel
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)
        // Create ActionSheet
        let actionSheet = UIAlertController(title: "Add Photo",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        // Add Actions
        actionSheet.addAction(openPhotoLibrary)
        actionSheet.addAction(openCamera)
        actionSheet.addAction(cancel)
        // Configure ActionSheet for iPad
        actionSheet.modalPresentationStyle = .popover
        if let presenter = actionSheet.popoverPresentationController {
            presenter.sourceView = sourceView
            presenter.sourceRect = sourceView.frame
        }
        // Show ActionSheet
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: for keyboard
    func hideKeyBoardTapScreen() {
        self.view.endEditing(true)
    }
    
    func listenerNotificationForSettings()  {
        // listener for change language settings
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeLanguage), name: Notification.Name(rawValue: NotificationID.CHANGE_LANGUAGE), object: nil )
        // listener for change language settings
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeTheme), name: Notification.Name(rawValue: NotificationID.CHANGE_THEME), object: nil )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: NotificationID.CHANGE_THEME), object: nil)
    }

    
    @objc func onChangeLanguage()  {
        // TODO: overide and update your UI
    }
    
    @objc func onChangeTheme()  {
        // TODO : overide and update theme
    }
    
    func showHideProgress(isShow: Bool)  {
        if isShow {
                     MBProgressHUD.showAdded(to: self.view, animated: true)
                }else{
                     MBProgressHUD.hide(for: self.view, animated: true)
                }
    }

    // init nav bar
    var barHeight = 20
    func getNavBarSize()  {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                break
            case 1334:
                print("iPhone 6/6S/7/8")
                break
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                break
            case 2436:
                print("iPhone X, XS")
                barHeight = 44
                break
            case 2688:
                print("iPhone XS Max")
                barHeight = 44
                break
            case 1792:
                print("iPhone XR")
                barHeight = 44
                break
            default:
                print("Unknown")
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
