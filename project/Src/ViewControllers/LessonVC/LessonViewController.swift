//
//  LessonViewController.swift
//  project
//
//  Created by SUUSOFT on 8/8/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit
import MBProgressHUD
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class LessonViewController: BaseViewController , IndicatorInfoProvider {
    
    var tabTitle : String = ""
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
      
    }
    
     let TAG_MENU_SEARCH = 1;
    
    @IBOutlet weak var collectionBook: UICollectionView!
    
    var listData = [Lesson]()
    var playListLessonMp3 = [Lesson]()
   
    var category: Category!
    var totalPage: Int = 1
    var currentPage: Int = 1
    var loading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
//        getDataSever()
        getLessons()
    }

   @objc func actionSearch(){
    
    }
    
    func getLessons() {
         showHideProgress(isShow: true)
          let param = [
                     "token" : DataStoreManager.shared().getToken(),
                     "category_id": category.id,
                     "page": currentPage,
                     "number_per_page" : 50
                     ] as [String : AnyObject]
        APIManagement.shared.getLessons(parameter: param, actionFail: { (status, message) in
            self.showToast(message: message)
            self.showHideProgress(isShow: false)
        }) { (status, message, totalPage, data) in
              self.showHideProgress(isShow: false)
            self.listData = data
            self.collectionBook.reloadData()
        }
    }

    func registerCell() {
        collectionBook.dataSource = self
        collectionBook.delegate = self
        collectionBook.register(UINib(nibName: "ItemLessonViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemLessonViewCell")
    }
}

extension LessonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBook.dequeueReusableCell(withReuseIdentifier: "ItemLessonViewCell", for: indexPath) as! ItemLessonViewCell
        cell.bind(index: indexPath.row, item: listData[indexPath.row])
        return cell
    }

    
}

extension LessonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let lesson = self.listData[indexPath.row]
        
         let controller = SubLessonViewController(nibName: "SubLessonViewController", bundle: nil)
         controller.lesson = lesson
         self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension LessonViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 24) / 3
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}




