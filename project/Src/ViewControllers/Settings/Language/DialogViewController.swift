//
//  DialogViewController.swift
//  project
//
//  Created by Mac on 9/1/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import UIKit

protocol ItemDiaLogSelectedDelegate {
    func onDialogItemSeleted(item : SettingObj)
}

class DialogViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tblData: UITableView!
    
    var delegate : ItemDiaLogSelectedDelegate!
    
    let identifierCell = "ItemDialogViewCell"
    var datas = [SettingObj]()
    var dialogTitle : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initTableView()
     
        
    }
    
    func initView()  {
        lblTitle.text = dialogTitle
    }
    
    func initTableView()  {
        tblData.dataSource = self
        tblData.delegate = self
        tblData.register(UINib(nibName: identifierCell, bundle: nil), forCellReuseIdentifier: identifierCell)
        
    }
    
        
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension DialogViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 48;
    }
    
}

extension DialogViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate.onDialogItemSeleted(item: datas[indexPath.row])
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! ItemDialogViewCell
        
        let drem = datas[indexPath.row]
        cell.bind(item: drem)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    

}
