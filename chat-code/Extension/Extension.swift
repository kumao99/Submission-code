//
//  Extension.swift
//  chat-code
//
//  Created by kumao on 2020/02/14.
//  Copyright © 2020 kumao. All rights reserved.
//

import Foundation
import UIKit


//アラート
extension UIViewController{
    func showerrorAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
}

