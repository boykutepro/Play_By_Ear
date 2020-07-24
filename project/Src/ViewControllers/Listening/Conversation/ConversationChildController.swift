//
//  ConversationChildController.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AVFoundation
import MediaPlayer
import MBProgressHUD
import Alamofire
import AVKit


class ConversationChildController: NavBarViewController , IndicatorInfoProvider {
   
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
    }
    var request: Alamofire.Request?
    
    let TAG_MENU_FAVORITE = 1;
    let TAG_MENU_DOWNLOAD = 2;
    
    @IBOutlet weak var textViewContent: UITextView! {
        didSet {
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
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var seekbar: UISlider!
    @IBOutlet weak var lblStartTime: UILabel! {
        didSet {
            self.lblStartTime.textColor = UIColor.colorWithHexString(Colors.primaryTextColor)
        }
    }
    @IBOutlet weak var lblEndtime: UILabel! {
        didSet {
            self.lblEndtime.textColor = UIColor.colorWithHexString(Colors.primaryTextColor)
        }
    }
    @IBOutlet weak var btnPlayPause: UIButton!{
        didSet{
            self.btnPlayPause.addTarget(self, action: #selector(handlePlayPauseTrack), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnNext: UIButton!{
        didSet {
            self.btnNext.addTarget(self, action: #selector(handleNextTrack), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnPrev: UIButton! {
        didSet {
            self.btnPrev.addTarget(self, action: #selector(handlePrevTrack), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var btnRepeat: UIButton! {
        didSet {
            self.btnRepeat.addTarget(self, action: #selector(handleRepeatTrack), for: .touchUpInside)
        }
    }
    
   
    @IBOutlet weak var btnShuffle: UIButton! {
        didSet {
            self.btnShuffle.addTarget(self, action: #selector(handlePrevTrack), for: .touchUpInside)
        }
    }
    
    @objc func handleShuffleTrack(){
        
    }
    
    @IBOutlet weak var viewPlayer: UIView!
    
    var lesson: Lesson! {
        didSet {
             playLesson()
        }
    }
    
    var tabTitle : String!
   
    var listData = [Conversation]()
    
    // for audio
    
    let audioPlayer : AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    override func isNavBar() -> Bool {
        return true
    }
    
    override func onNavBack() {
        audioPlayer.pause()
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavTitle(title: lesson.name)
        configNav()
        checkFavorited()
        checkDownloaded()
        observePlayerCurrentTime()
        self.customizeUI()
        initData()
        
    }
    
    func resetDataAudio(lesson : Lesson) {
        self.setNavTitle(title: lesson.name)
        self.textViewContent.text = lesson.content
        seekbar.value = 0;
        lblEndtime.text = "00:00"
        lblStartTime.text = "00:00"
    }
    func customizeUI() {
        viewPlayer.backgroundColor = UIColor.colorWithHexString(Colors.secondPrimaryColor)
        self.view.backgroundColor = UIColor.colorWithHexString(Colors.secondPrimaryColor)
    }
    
    func initData()  {
             self.textViewContent.text = lesson.content
    }
    
    func setImage(image: UIImage , button: UIButton)  {
        button.setImage(image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.colorWithHexString(Colors.white)
    }
    
    @IBAction func handleCurrentTimeSliderChange(_ sender: Any) {
        let precentage = seekbar.value
        guard let duration = audioPlayer.currentItem?.duration else {return}
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(precentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        audioPlayer.seek(to: seekTime)
    }
    
    fileprivate func playLesson() {
        if lesson.type == LessonType.TYPE_LOCAL {
            self.playMp3UsingFileUrl()
        } else {
            guard let url = URL(string: self.lesson.link_url) else {return}
            let playItem = AVPlayerItem(url: url)
            self.audioPlayer.replaceCurrentItem(with: playItem)
            audioPlayer.play()
        }
    }
    
    fileprivate func playMp3UsingFileUrl(){
        print("Attempt to play music with file url:",lesson.getUrl())
        let playItem = AVPlayerItem(url:lesson.getUrl())
        self.audioPlayer.replaceCurrentItem(with: playItem)
        audioPlayer.play()
    }
    
    
    
    @objc func handlePlayPauseTrack(){
        if audioPlayer.timeControlStatus == .paused {
            audioPlayer.play()
            btnPlayPause.setImage(#imageLiteral(resourceName: "Group 2"), for: .normal)
        } else {
            audioPlayer.pause()
            btnPlayPause.setImage(#imageLiteral(resourceName: "Logo"), for: .normal)
        }
    }

    fileprivate func observePlayerCurrentTime(){
        let interval = CMTimeMake(value: 1, timescale: 2)
        audioPlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.lblStartTime.text = time.toDisplayString()
            let durationTime = self?.audioPlayer.currentItem?.duration
            self?.lblEndtime.text = durationTime?.toDisplayString()
            self?.updateCurrentTimeSlider()
        }
    }
    
    fileprivate func updateCurrentTimeSlider(){
        let currentTimeSeconds = CMTimeGetSeconds(audioPlayer.currentTime())
        let durationSeconds =  CMTimeGetSeconds(audioPlayer.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.seekbar.value = Float(percentage)
        print(self.seekbar.value )
    }
    
    var playListLessonMp3 = [Lesson]()
    
    @objc func handleNextTrack(){
        if playListLessonMp3.isEmpty {return}
        let currentLessonIndex = playListLessonMp3.firstIndex { (lesson) -> Bool in
            return self.lesson.image == lesson.image && self.lesson.name == lesson.name
        }
         guard let index =  currentLessonIndex else { return }
         let nextLesson : Lesson
         if index == playListLessonMp3.count - 1 {
            nextLesson = playListLessonMp3[0]
        } else {
            nextLesson = playListLessonMp3[index + 1]
        }
        self.lesson = nextLesson
        self.resetDataAudio(lesson: lesson)
    }
    
    fileprivate func seekToCurrentTime(delta: Int64) {
        let seconds = CMTimeMake(value: delta, timescale: 1)
        let seekTime = CMTimeAdd(audioPlayer.currentTime(), seconds)
        audioPlayer.seek(to: seekTime)
    }
    
    @objc func handleRepeatTrack(){
        if playListLessonMp3.isEmpty {return}
        let currentLessonIndex = playListLessonMp3.firstIndex { (lesson) -> Bool in
            return self.lesson.image == lesson.image && self.lesson.name == lesson.name
        }
        guard let index = currentLessonIndex else {return}
        self.lesson = playListLessonMp3[index]
        self.resetDataAudio(lesson: lesson)
    }
    
    @objc func handlePrevTrack(){
        if playListLessonMp3.isEmpty {return}
        let currentLessonIndex = playListLessonMp3.firstIndex { (lesson) -> Bool in
            return self.lesson.image == lesson.image && self.lesson.name == lesson.name
        }
        guard let index = currentLessonIndex else {return}
        let prevLesson : Lesson
        if index == 0 {
            let count = self.playListLessonMp3.count
            prevLesson = playListLessonMp3[count - 1]
            
        } else {
            prevLesson = playListLessonMp3[index - 1]
        }
        self.lesson = prevLesson
        self.resetDataAudio(lesson: lesson)
    }
    
}


