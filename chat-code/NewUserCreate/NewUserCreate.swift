//
//  NewUserCreate.swift
//  chat-code
//
//  Created by kumao on 2020/02/03.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import PKHUD
import FirebaseFirestore

class NewUserCreate: UIViewController,UITextFieldDelegate {
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    
    @IBOutlet weak var registerStackView: UIStackView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var kanaField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var tapBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapBtn.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeNotification(notification:)), name: UITextField.textDidChangeNotification, object: nil)
        
        
        
        //textFieldの設定
        nameField.delegate = self
        kanaField.delegate = self
        userNameField.delegate = self
        birthField.delegate = self
        addressField.delegate = self
        
        //datePickerの設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        birthField.inputView = datePicker
        
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定(紐づいているUITextfieldへ代入)
        birthField.inputView = datePicker
        birthField.inputAccessoryView = toolbar
        
        
    }
    
    
    @objc func done() {
        birthField.endEditing(true)
        
        //日付設定のフォーマット
        let formatter = DateFormatter()
        //表示するフォーマットの設定
        formatter.dateFormat = "yyyy年MM月dd日"
        /*(from: datePicker.date)を指定することで、
        textFieldに指定した日付が表示される*/
        birthField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    
    
    @IBAction func registerTapBtn(_ sender: Any) {
        
        print("登録ボタン押したよ")
//        guard let title = nameField.text, let kana = kanaField.text, let _ = userNameField.text, let _ = birthField.text, let _ = addressField.text else {
//                   return
//               }
//
//        if title.isEmpty, kana.isEmpty {
//                   HUD.flash(.labeledError(title: nil, subtitle: "お名前が入力されていません"), delay: 1)
//
//                   return
//               }
        
        
        
    }
    
    
    
    //未入力項目がある時はボタンを押せなくする
   @objc func didChangeNotification(notification: Notification) {
    tapBtn.isEnabled = nameField.text?.isEmpty == false && kanaField.text?.isEmpty == false && userNameField.text?.isEmpty == false && birthField.text?.isEmpty == false && addressField.text?.isEmpty == false
    tapBtn.backgroundColor = UIColor.gray
    }
    
    

  
    //storyboardを使ってTabPageに遷移
    func presentProfilePage() {
        
        let storyBoard = UIStoryboard(name: "TabPage", bundle: nil)
        guard let vc = storyBoard.instantiateInitialViewController() else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //リターンキーでキーボード閉じる
    func textFieldShouldReturn( _ textField : UITextField) -> Bool {
        textField.resignFirstResponder()

    }
    
    
    
}





