//
//  FavoriteController.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit

class FavoriteController : NavBarViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgGrid: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    
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
        setNavTitle(title: "FAVORITE".localized())
        addActionMenu(id: TAG_MENU_DELETE, image: #imageLiteral(resourceName: "ic_remove"))
    }
    
    func configListView()  {
        
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        homeCollectionView.register(UINib(nibName: "ItemLessonViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemLessonViewCell")

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
        if FAVORITE_LESSON.count <= 0  {
            return
        }
        showAlert(title: "", message: "Do you want to unfavorite all?", btnLeft: "No", actionLeft: {
            
        }, btnRight: "Yes") {
            FAVORITE_LESSON = [Lesson]()
            self.homeCollectionView.reloadData()
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let lesson = FAVORITE_LESSON[indexPath.row]
              if lesson.type == LessonType.TYPE_AUDIO {
                  let controller = ConversationChildController()
                  controller.lesson = lesson
                  self.navigationController?.pushViewController(controller, animated: true)
              }else if lesson.type == LessonType.TYPE_VIDEO{
                let controller = VideoLessonViewController()
                controller.lesson = lesson
                self.navigationController?.pushViewController(controller, animated: true)
              }  else if lesson.type == LessonType.TYPE_LOCAL  {
                let controller = ConversationChildController()
                controller.lesson = lesson
                self.navigationController?.pushViewController(controller, animated: true)
             }
              
           
              QueuItemManager.shared().addNewQueue(item: lesson)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FAVORITE_LESSON.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemLessonViewCell", for: indexPath) as! ItemLessonViewCell
      
        
        return cell
    }
    
    
    
}


extension FavoriteController: UICollectionViewDelegateFlowLayout {
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
