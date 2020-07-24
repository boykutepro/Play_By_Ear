//
//  SearchView.swift
//  project
//
//  Created by tranthanh on 3/8/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

protocol MyViewDelegate {
    func didTapButton(lesson : Lesson)
}


class SearchView : UIView , UITextFieldDelegate , UISearchBarDelegate {
    
    var delegate: MyViewDelegate!
    

    @IBOutlet weak var searchTextField: UITextField!
    
    var lessonSearchView = MyFooterView.viewFromNib
    var listData : [Lesson] = []
    var playListLessonMp3 = [Lesson]()
    @IBAction func backBtn(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var timer: Timer?
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
//            self.getDataSever(keyword : searchText)
//            self.tableView.reloadData()
//        })
//    }
    
    
    func initsearchBar(){
        searchBar.delegate = self
    }
    func initTextField(){
        searchTextField.delegate = self
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = UITextField.ViewMode.always
        searchTextField.textColor = UIColor.colorWithHexString(Colors.primaryTextColor)
        DispatchQueue.main.async {
            self.searchTextField.becomeFirstResponder()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initTextField()
        initTableView()
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchText  = textField.text! + string
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { timer in
            self.getDataSever(keyword : searchText)
            
        })
        return true
    }
    
    
    
    
    
    func getDataSever(keyword : String){
        let param = [
            "token" : DataStoreManager.shared().getToken(),
            "keyword": keyword ,
            "page": 1,
            "number_per_page" : 10
            ] as [String : AnyObject]
        APIManagement.shared.searchFullLesson(parameter: param, actionFail: { (status, code) in
    
        }) { (status, message, searchFull) in
            self.listData = searchFull.songs
            self.tableView.reloadData()
        }
        
    }
    
    
    fileprivate func initTableView(){
        tableView.register(MyTableViewCell.nib, forCellReuseIdentifier: MyTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
}



extension SearchView : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.className, for: indexPath) as! MyTableViewCell
        cell.lesson = listData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20 , weight: .semibold)
        label.textColor = UIColor.colorWithHexString(Colors.primaryColor)
        return label
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return lessonSearchView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.listData.isEmpty && searchTextField.text?.isEmpty == true ? 120 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.listData.isEmpty && searchTextField.text?.isEmpty  == false ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = self.listData[indexPath.row]
        self.removeFromSuperview()
        delegate?.didTapButton(lesson: lesson)
        QueuItemManager.shared().addNewQueue(item: lesson)
    }
}



//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchTextField.endEditing(true)
//        return true
//    }
//
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if searchTextField.text != "" {
//            return true
//        } else {
//            searchTextField.placeholder = "Type Something"
//            self.listData.removeAll()
//            return false
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        //get search
//        if let keyword = searchTextField.text {
//            self.getDataSever(keyword : keyword)
//        }
//         searchTextField.text = ""
//    }
