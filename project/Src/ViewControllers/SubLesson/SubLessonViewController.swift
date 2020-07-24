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

class SubLessonViewController: NavBarViewController {
    
    @IBOutlet weak var collectionBook: UICollectionView!
    
    var lesson: Lesson!
    var listData = [Lesson]()
    var playListLessonMp3 = [Lesson]()
   
    var totalPage: Int = 1
    var currentPage: Int = 1
    var loading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: lesson.name)
        registerCell()
        getLessons()
    }

    override func  isNavBar() -> Bool {
           return true
       }
    
    func getLessons() {
         showHideProgress(isShow: true)
          let param = [
                     "token" : DataStoreManager.shared().getToken(),
                     "lesson_id": lesson.id,
                     "page": currentPage,
                     "number_per_page" : 100
                     ] as [String : AnyObject]
        APIManagement.shared.getSubLessons(parameter: param, actionFail: { (status, message) in
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
        collectionBook.register(UINib(nibName: "ItemSubLessonViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemSubLessonViewCell")
    }
}

extension SubLessonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBook.dequeueReusableCell(withReuseIdentifier: "ItemSubLessonViewCell", for: indexPath) as! ItemSubLessonViewCell
        cell.lesson = listData[indexPath.row]
        return cell
    }

    
}

extension SubLessonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let lesson = self.listData[indexPath.row]
       

        QueuItemManager.shared().addNewQueue(item: lesson)
    }
}

extension SubLessonViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2 * 8)
        let height = collectionView.frame.size.height / 7
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 8, bottom: 16, right: 8)
    }
    
}




