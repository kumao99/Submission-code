//
//  CustomTextField.swift
//  chat-code
//
//  Created by kumao on 2020/02/06.
//  Copyright © 2020 kumao. All rights reserved.
//

import Foundation
import UIKit


class CustomTextField: UITextField {
    
    // 下線用のUIViewを作っておく
    let underline: UIView = UIView()

    override func layoutSubviews() {
        super.layoutSubviews()
        //textFieldの高さ設定
//        self.frame.size.height = 50
        
        //スタイルの追加設定
        composeUnderline()
        
        self.borderStyle = .none
//        self.placeholder = ""
    }
    
    private func composeUnderline() {
        self.underline.frame = CGRect(
            x: 0,
            y: self.frame.height,
            width: self.frame.width,
            height: 0.5)
        
        self.underline.backgroundColor = UIColor(red:0.35, green:0.40, blue:0.40, alpha:1.0)
        
        self.addSubview(self.underline)
        self.bringSubviewToFront(self.underline)
        
    }
}
