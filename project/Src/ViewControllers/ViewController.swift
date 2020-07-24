//
//  ViewController.swift
//  project
//
//  Created by Mac on 7/14/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let user = DataStoreManager.shared().getUser()
        let controller = HomeViewController(nibName: "HomeViewController", bundle: nil)
         self.navigationController?.pushViewController(controller, animated: true)
//        if !user.userName.isEmpty{
//            let tabbarVC = MainTabBarController()
//            self.navigationController?.pushViewController(tabbarVC, animated: true)
//        }else{
//            let loginVC = LoginViewController()
//            self.navigationController?.pushViewController(loginVC, animated: true)
//        }
        
    }

}
