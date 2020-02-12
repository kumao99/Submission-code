//
//  FirstPage.swift
//  chat-code
//
//  Created by kumao on 2020/02/01.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit

class FirstPage: UIViewController {
    
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var key: BGButton!
    @IBOutlet weak var talk: BGButton!
    @IBOutlet weak var usage: BGButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImg.layer.cornerRadius = 50
        userImg.image = UIImage(named: "panda")

        
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
