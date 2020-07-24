//
//  HomeViewController.swift
//  AT-Template-iOS
//
//  Created by Mac on 8/14/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON


class HomeViewController: SlidingTabStripController  {
    
    var listData : [Category] = []
    var listDataLesson : [Lesson] =  [Lesson]()
    let TAG_MENU_SEARCH = 1;
    let TAG_MENU_LIST = 2;
    
    var navBar: NavBarView!
    let heightSceen: CGFloat = UIScreen.main.bounds.height
    let widthSceen: CGFloat = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let window = UIApplication.shared.keyWindow
        let searchView = Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)?[0] as! SearchView
        searchView.delegate = self
        searchView.frame = self.view.frame
        window?.addSubview(searchView)
    }
    
    func getCategories()  {
          let param = [
            "page" : 1,
            "number_per_page" : 50,
            "token" : DataStoreManager.shared().getToken(),
          ] as [String : AnyObject]
        APIManagement.shared.listCategories(url: API.listCategory ,parameter: param, actionFail: { (status, message) in
            self.showToast(message: message)
          }) { (status, message, totalPage, data) in
            self.listData = data
            self.reloadPagerTabStripView()
          }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var listchildrenVC : [UIViewController] = []
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        if listData.count > 0 {
            listData.forEach { (category) in
                let newVC = LessonViewController()
                newVC.tabTitle = category.name
                newVC.category = category
                listchildrenVC.append(newVC)
            }
            return listchildrenVC
        } else {
            let empty = EmptyChildViewController()
            return [empty]
        }
        
    }
}

class EmptyChildViewController: UIViewController, IndicatorInfoProvider {
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "")
    }
}



extension HomeViewController : MyViewDelegate {
    func didTapButton(lesson: Lesson) {
        switch lesson.type {
        case LessonType.TYPE_AUDIO:
            let controller = ConversationChildController(nibName: "ConversationChildController", bundle: nil)
            controller.lesson = lesson
            self.navigationController?.pushViewController(controller, animated: true)

        default:
            let controller = VideoLessonViewController(nibName: "VideoLessonViewController", bundle: nil)
            controller.lesson = lesson
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
