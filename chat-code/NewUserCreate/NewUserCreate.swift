//
//  NewUserCreate.swift
//  chat-code
//
//  Created by kumao on 2020/02/03.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import Firebase

class NewUserCreate: UIViewController,UITextFieldDelegate {
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    
    
    
    
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var kanaField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var addressFiel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textFieldの設定
        nameField.delegate = self
        kanaField.delegate = self
        mailField.delegate = self
        passField.delegate = self
        birthField.delegate = self
        addressFiel.delegate = self
        
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
        guard let email = mailField.text,
            let password = passField.text else {return}
        if email.isEmpty {
            showerrorAlert(title: "入力エラー", message: "メールアドレスを入力してください")
            return
        }
        if password.isEmpty{
            showerrorAlert(title: "入力エラー", message: "パスワードを入力してください")
            return
        }
        
        signUp(email: email, password: password)
        
        
        
    }
    
    
    
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                self.signUpErrorAlert(error)
                print("登録失敗")
            }else{
                self.presentProfilePage()
                print("登録成功")
            }
        }
    }
    
    
    func signUpErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code){
            var message = ""
            switch errCode {
            case .invalidEmail:message = "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse:message = "既に登録されているメールアドレスです"
            case .weakPassword:message = "パスワードは6文字以上で入力してください"
            default:message = "エラー: \(error.localizedDescription)"
                
            }
            showerrorAlert(title: message, message: message)
        }
    }
    
    func presentProfilePage() {
        
        let storyBoard = UIStoryboard(name: "TabPage", bundle: nil)
        guard let vc = storyBoard.instantiateInitialViewController() else {
            print("viewControllerがないよ")
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func textFieldShouldReturn( _ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        
    }
    
    
    
}


extension UIViewController{
    func showerrorAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
}


