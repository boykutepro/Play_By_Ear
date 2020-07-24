//
//  VideoLessonViewController.swift
//  project
//
//  Created by Trang Pham on 1/1/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import WebKit
import MBProgressHUD
import Alamofire
import XLPagerTabStrip

class VideoLessonViewController: NavBarViewController , IndicatorInfoProvider {
    var tabTitle : String!
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
    }
    var request: Alamofire.Request?
    let TAG_MENU_FAVORITE = 1;
    let TAG_MENU_DOWNLOAD = 2;
    

    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var viewer: UIView!
    @IBOutlet weak var viewCOntent: UIView!
    @IBOutlet weak var textViewContent: UITextView! {
        didSet{
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            style.lineSpacing = 15
            let attributes = [NSAttributedString.Key.paragraphStyle: style]
            self.textViewContent.attributedText = NSAttributedString(string: lesson.content, attributes: attributes)
            self.textViewContent.textColor = UIColor.colorWithHexString(Colors.primaryTextColor)
            self.textViewContent.font = UIFont.systemFont(ofSize: 16)
            self.textViewContent.isEditable = false
        }
    }
    var webView: WKWebView!
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    var lesson: Lesson!
    
    override func isNavBar() -> Bool {
        return true
    }
    
    fileprivate func playVideo() {
        if lesson.link_url != nil {
            playVideoUsingFileUrl()
        } else {
            let url = URL(string: self.lesson.link_url)
            let item = AVPlayerItem(url: url!)
            self.player = AVPlayer(playerItem: item)
            self.avpController = AVPlayerViewController()
            self.avpController.player = self.player
            self.avpController.view.frame = self.viewVideo.frame
            self.addChild(self.avpController)
            self.viewer.addSubview(self.avpController.view)
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, options: [])
            }
            catch {
                self.showToast(message: "Setting category to AVAudioSessionCategoryPlayback failed.")
            }
        }
    }
    
    fileprivate func playVideoUsingFileUrl(){
        print("Attempt to play video with file url:",lesson.getUrl())
        self.player = AVPlayer(url: lesson.getUrl())
        self.avpController = AVPlayerViewController()
        self.avpController.player = self.player
        self.avpController.view.frame = self.viewVideo.frame
        self.addChild(self.avpController)
        self.viewer.addSubview(self.avpController.view)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: [])
        }
        catch {
            self.showToast(message: "Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: self.lesson.name)
        configNav()
        checkFavorited()
        DispatchQueue.main.async {
            self.playVideo()
        }
    }
    
    override func onNavBack() {
        player.pause()
        player = nil
        self.navigationController?.popViewController(animated: true)
    }
}
