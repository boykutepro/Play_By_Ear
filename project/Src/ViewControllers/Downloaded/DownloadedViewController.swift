//
//  DownloadedViewController.swift
//  project
//
//  Created by SUUSOFT on 8/16/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DownloadedViewController:  NavBarViewController ,  IndicatorInfoProvider {
    var tabTitle : String!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
    }
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
     let TAG_MENU_DELETE = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavBar()
        configListView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeCollectionView.reloadData()
    }
    
    func configNavBar()  {
        setNavTitle(title: "Download".localized())
        addActionMenu(id: TAG_MENU_DELETE, image: #imageLiteral(resourceName: "ic_remove"))
        
    }
    
    func configListView()  {
//        
//        homeCollectionView.dataSource = self
//        homeCollectionView.delegate = self
//        homeCollectionView.register(UINib(nibName: "ItemLessonViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemLessonViewCell")
        
    }
    
    func onItemMenuSelected(_ sender: UIButton) {
        switch sender.tag {
        case TAG_MENU_DELETE:
            actionDelete()
            break
        default:
            break
        }
    }
    
    
  
    func actionDelete() {
        if DOWNLOADED_LESSON.count <= 0  {
            return
        }
        showAlert(title: "", message: "Do you want to unfavorite all?", btnLeft: "No", actionLeft: {
        }, btnRight: "Yes") {
            DOWNLOADED_LESSON = [Lesson]()
            self.homeCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let converVC = ConversationChildController()
        converVC.lesson = DOWNLOADED_LESSON[indexPath.row]
        self.navigationController?.pushViewController(converVC, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DOWNLOADED_LESSON.count
    }
    
  
}


extension DownloadedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 16) / 2
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
