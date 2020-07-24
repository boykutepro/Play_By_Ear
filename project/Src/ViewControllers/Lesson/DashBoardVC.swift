//
//  DashBoardVC.swift
//  EBook
//
//  Created by Minh Bui on 8/22/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import MBProgressHUD
import XLPagerTabStrip

class DashBoardVC: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var collectionBook: UICollectionView!

    var listData = [Lesson]()
    var tabTitle : String!
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerCell()
        getData()
        
    }
    
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
    }
    
    func getData() {
        let param = [
            "category" : category.id,
            ] as [String : AnyObject]
        APIManagement.shared.getLessons(parameter: param, actionFail: { (status, message) in
            
        }) { (status, message, data) in
            self.listData = data
            self.tableBook.reloadData()
        }
    }
    
    func registerCell() {
        collectionBook.dataSource = self
        collectionBook.delegate = self
        collectionBook.register(UINib(nibName: "ItemLessonViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemLessonViewCell")
    }
    
   
}

extension DashBoardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBook.dequeueReusableCell(withReuseIdentifier: "ItemLessonViewCell", for: indexPath) as! ItemLessonViewCell
        cell.bind(item: listData[indexPath.row])
        return cell
    }
}

extension DashBoardVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if !HISTORY_BOOK.contains(where: { $0.title == listBook[indexPath.row].title }) {
//            HISTORY_BOOK.append(listBook[indexPath.row])
//        }
//        let chapter = storyboard?.instantiateViewController(withIdentifier: "DetailChapterBookVC") as! DetailChapterBookVC
//        chapter.bookChapter = listBook[indexPath.row]
//        self.navigationController?.pushViewController(chapter, animated: true)
    }
}

extension DashBoardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 8 * 3 ) / 2
        let height = (self.view.frame.height - 16 * 3 ) / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}



