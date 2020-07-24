//
//  NavBarConversation.swift
//  project
//
//  Created by tranthanh on 2/25/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit

import MBProgressHUD
import Alamofire

extension ConversationChildController {
    @objc func checkDownloaded(){
        let item = lesson
        if DOWNLOADED_LESSON.contains(where: { $0.id == item!.id }) {
            navBar.updateMenuImage(tag : TAG_MENU_DOWNLOAD, image : #imageLiteral(resourceName: "idownloaded"))
        }else{
            navBar.updateMenuImage(tag : TAG_MENU_DOWNLOAD, image : #imageLiteral(resourceName: "idownload"))
        }
    }
    func checkFavorited() {
        let item = lesson
        if FAVORITE_LESSON.contains(where: { $0.id == item!.id }) {
            navBar.updateMenuImage(tag : TAG_MENU_FAVORITE, image : #imageLiteral(resourceName: "heart"))
        }else{
            navBar.updateMenuImage(tag : TAG_MENU_FAVORITE, image : #imageLiteral(resourceName: "heart1"))
        }
    }
    func configNav()  {
        navBar.addActionMenu(id: TAG_MENU_FAVORITE, image: #imageLiteral(resourceName: "heart1"))
        navBar.addActionMenu(id: TAG_MENU_DOWNLOAD, image: #imageLiteral(resourceName: "idownload"))
    }
    func onItemMenuSelected(_ sender: UIButton) {
        switch sender.tag {
        case TAG_MENU_FAVORITE:
            actionFavorite()
            break
        case TAG_MENU_DOWNLOAD:
            actionDownload()
            break
        default:
            break
        }
    }
    func actionFavorite()  {
        let item = lesson
        if !FAVORITE_LESSON.contains(where: { $0.id == item!.id }) {
            FAVORITE_LESSON.append(item!)
            navBar.updateMenuImage(tag : TAG_MENU_FAVORITE, image : #imageLiteral(resourceName: "heart"))
            showToast(message: "Favourited")
        }else{
            let size = FAVORITE_LESSON.count
            for i in 0...size {
                let song = FAVORITE_LESSON[i]
                if song.id == item!.id{
                    FAVORITE_LESSON.remove(at: i)
                    break
                }
            }
            navBar.updateMenuImage(tag : TAG_MENU_FAVORITE, image : #imageLiteral(resourceName: "heart1"))
            showToast(message: "Un Favourited")
        }
    }
    func actionDownload()  {
        let item = QueuItemManager.shared().getCurrentItem()
        if DOWNLOADED_LESSON.contains(where: { $0.id == item.id }) {
            self.showToast(message: "The file was downloaded")
            return
        }
        let attachment =  item.link_url
        let arrAttachment = attachment.components(separatedBy: "/")
        let nameLocalFile = arrAttachment[arrAttachment.count - 1]
        let destination1: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(nameLocalFile)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let hudView = MBProgressHUD.showAdded(to: self.view, animated: true)
        hudView.mode = MBProgressHUDMode.determinateHorizontalBar
        hudView.button.setTitle("Cancel", for: .normal)
        hudView.button.addTarget(self, action: #selector(cancelDownload), for: .touchUpInside)
        self.request = Alamofire.download(item.getUrl(), to: destination1).downloadProgress(closure: { (progress) in
            hudView.progress = Float(progress.fractionCompleted)
            let progressNow = round(progress.fractionCompleted * 100)
            hudView.label.text = "Downloading..."
            hudView.detailsLabel.text = "\(progressNow) %"
        }).responseData
            { response in
                if response.result.isFailure {
                    hudView.hide(animated: true)
                    self.navBar.updateMenuImage(tag : self.TAG_MENU_DOWNLOAD, image : #imageLiteral(resourceName: "idownload"))
                    self.showToast(message: "Error Download")
                } else {
                    hudView.hide(animated: true)
                    item.link_url = nameLocalFile
                    item.type = "local"
                    DOWNLOADED_LESSON.append(item)
                    self.navBar.updateMenuImage(tag : self.TAG_MENU_DOWNLOAD, image : #imageLiteral(resourceName: "idownloaded"))
                    self.showToast(message: "Downloaded")
                }
        }
    }
    @objc func cancelDownload() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.request?.cancel()
    }
}
