//
//  RootSplashVC.swift
//  project
//
//  Created by Mac on 8/16/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        view.backgroundColor = .white
       let controller = HomeViewController(nibName: "HomeViewController", bundle: nil)
      // self.navigationController?.pushViewController(controller, animated: true)
         viewControllers = [controller]
//        let user = DataStoreManager.shared().getUser()
//        if user.userName.isEmpty {
//             //assume user is logged in
//            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
//        }else{
//             let homeController = MainTabBarController()
//             viewControllers = [homeController]
//        }
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
         viewControllers = [loginController]
    }
}
