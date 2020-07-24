//
//  .swift
//  project
//
//  Created by Phan Van Da on 8/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import  LBTATools

protocol LoginControllerDelegate: class {
    func finishLoggingIn(email: String , pass : String)
    func loginFacebook()
    func loginGoogle()
    func register()
}

class LoginViewController: BaseViewController , GIDSignInUIDelegate , GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
          return
        }
        let fullName = user.profile.name
        let email = user.profile.email
        let urlAvatar = user.profile.imageURL(withDimension: 400).absoluteString
          GIDSignIn.sharedInstance().signOut()
         self.loginToServer(loginType: "s",email: email!, password: "", name: fullName!, image: urlAvatar)
    }
    
    private func configureGoogle() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor =  UIColor.colorWithHexString(Colors.primaryColor)
          layout()
          registerCells()
          observeKeyboardNotifications()
          configureGoogle()
          }
               func loginNav(){
               //we'll perhaps implement the home controller a little later
               let rootViewController = UIApplication.shared.keyWindow?.rootViewController
               guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
               mainNavigationController.viewControllers = [MainTabBarController()]
        }
    
    func loginToServer(loginType: String,email: String, password: String, name:String, image: String){
        showHideProgress(isShow: true)
        let url = API.login
        let param = [
            "username" : email,
            "password" : password,
            "name" : name,
            "type" : 2,
            "status" : 1,
            "login_type" : loginType,
            "avatar" : image
            ] as [String : AnyObject]
        APIManagement.shared.user(pathURL: url, parameter: param, actionFail: { (status, message) in
             self.showHideProgress(isShow: false)
            self.showAlert(title: "", message: message, btnLeft: "", actionLeft: nil, btnRight: "OK", actionRight: nil)
        }) { (user) in
             self.showHideProgress(isShow: false)
             DataStoreManager.shared().saveUser(user: user!)
            self.loginNav()
        }
    }
    
    
    var pages : [Page] = [
        Page(imageName: "1"),
        Page(imageName: "2"),
        
    ]
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return button
    }()
    
    @objc func skip() {
        // we only need to lines to do this
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    @objc func nextPage() {
        //we are on the last page
        if pageControl.currentPage == pages.count {
            return
        }
        
        //second last page
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    
    
    
  
    
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.className)
        collectionView.register(LoginCollectionViewCell.nib, forCellWithReuseIdentifier: LoginCollectionViewCell.className)
    }
    
    func register() {
        let controller  = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func layout() {
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        if #available(iOS 11.0, *) {
            pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
            skipButtonTopAnchor = skipButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
            
            nextButtonTopAnchor = nextButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
            
            //use autolayout instead
            collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        } else {
            // Fallback on earlier versions
        }
        //
        
        
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        //we are on the last page
        if pageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            //back on regular pages
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 0
            nextButtonTopAnchor?.constant = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 80
        skipButtonTopAnchor?.constant = -80
        nextButtonTopAnchor?.constant = -80
    }
}
extension LoginViewController : LoginControllerDelegate {
    func loginGoogle() {
         GIDSignIn.sharedInstance().signIn()
    }
    
    func checkInformation(email:String , pass : String) -> Bool {
            if (!Utilities.validateEmail(email)) {
              self.showAlertNormal(title: "Error", message: "Invalid gmail, please try again")
              return false
            }
            if (!Utilities.validateInfomation(pass, minCharacter: 1, maxCharacter: 32)) {
              self.showAlertNormal(title: "Missing", message: "Please enter your password")
              return false
            }
            return true
    }
    func saveUser(user: User)  {
           DataStoreManager.shared().saveUser(user: user)
       }
    

    func finishLoggingIn(email: String, pass: String) {
        if checkInformation(email: email, pass: email) {
             self.loginToServer(loginType: "n", email: email, password: pass, name: "", image: "")
        }
    }
    
    func loginFacebook() {
        let loginManager: LoginManager = LoginManager()
        loginManager.logOut()
        if AccessToken.current != nil {
          getUserFromFB()
          print("Logined")
        } else {
            loginManager.logIn(permissions: ["public_profile", "email", "user_friends"], from: self,
                             handler: { (result, error) in
                              if error != nil {
                                print("Login Error")
                              } else if (result?.isCancelled)! {
                                print("Cancel Login")
                              } else {
                                self.getUserFromFB()
                                print("Success Login")
                              }
          })
        }
    }
    
    
    private func getUserFromFB() {
      let graphRequest: GraphRequest = GraphRequest(graphPath: "/me", parameters: ["fields": "name, email, picture.type(large)"])
      graphRequest.start { (connection, result, error) in
        if error != nil {
          self.showAlertNormal(title: "ERROR", message: "Not connected to Facebook")
          return
        } else {
          if let dataResult = result as? [String: AnyObject] {
            let name = dataResult["name"] as? String
            let email = dataResult["email"] as? String
            var urlAvatar = ""
            if let dataPicture = dataResult["picture"] as? [String: AnyObject] {
              if let data = dataPicture["data"] as? [String: AnyObject] {
                urlAvatar = (data["url"] as? String)!
              }
            }
            if email == "" {
              self.showAlertNormal(title: "ERROR", message: "Login failed, Please try again with another acccount")
              return
            }
              self.loginToServer(loginType: "s", email: email!, password: "", name: name!, image: urlAvatar)
          }
        }
        
      }
    }
}
extension LoginViewController : UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // we're rendering our last login cell
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCollectionViewCell.className, for: indexPath) as! LoginCollectionViewCell
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.className, for: indexPath) as! PageCell
        let page = pages[(indexPath as NSIndexPath).item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
}
extension LoginViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        //        print(UIDevice.current.orientation.isLandscape)
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        //scroll to indexPath after the rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
        
    }
}
extension UIView {
    func configUIHighLight(_ set: Bool) {
        if (set){
            self.frame.size.height = 2
            self.backgroundColor? = UIColor.white
        } else {
            self.frame.size.height = 1
            self.backgroundColor? = UIColor(red: 220/250, green: 220/250, blue: 220/250, alpha: 1)
        }
    }
}

