//
//  TabPage.swift
//  chat-code
//
//  Created by kumao on 2020/02/05.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import WebKit

class TabPage: UIViewController {
    

    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.layer.cornerRadius = 10
        //はみ出た部分を非表示
        icon.clipsToBounds = true
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName:CustomCell.className, bundle: nil), forCellReuseIdentifier:CustomCell.className)
//
//

       
    }
    
    
    @IBAction func keyTab(_ sender: Any) {
    }
    
    
    
    @IBAction func chatTab(_ sender: Any) {
        let vc = Chat.instantiate()
               present(vc, animated: true)
    }
    
    
    @IBAction func settingTab(_ sender: Any) {
        let vc = EditProfile.instantiate()
        present(vc, animated: true)
    }
    
    
    //tableviewの設定
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return site.count
//       }
//
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       }
       
    
   

}

   
