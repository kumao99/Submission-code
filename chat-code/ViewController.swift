//
//  ViewController.swift
//  chat-code
//
//  Created by kumao on 2020/02/01.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    
    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.cornerRadius = 5
        
        
        signInBtn.layer.borderWidth = 1
        signInBtn.layer.borderColor = UIColor.white.cgColor
        signInBtn.layer.cornerRadius = 5
        
        
        mailField.delegate = self
        passField.delegate = self
        
    }
    
    //ログイン
    @IBAction func loginBtn(_ sender: Any) {
        
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
        
        logIn(email: email, password: password)
    }
    
    
    
    //新規登録
    @IBAction func signBtn(_ sender: Any) {
        
        guard let email = mailField.text, let password = passField.text else {
            return
        }
        if email.isEmpty {
            showerrorAlert(title:"入力エラー", message: "メールアドレスを入力してください")
            return
        }
        if password.isEmpty {
            showerrorAlert(title: "入力エラー", message: "パスワードを入力してください")
            return
        }
        signIn(email: email, password: password)
    }
    
    
    
    //FirebaseAuthのログイン
    func logIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                self.logInErrorAlert(error)
                print("ログイン失敗")
            }else{
                self.presentTabPage()
                print("ログイン成功")
            }
        }
    }
    
    //FirebaseAuthの新規登録
    func signIn(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                self.signInErrorAlert(error)
                print("登録失敗")
            }else{
                self.presentNewUser()
                print("登録成功")
            }
        }
    }
    
    
    
    //ログイン時のエラーアラート
    func logInErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code){
            var message = ""
            switch errCode {
            case .userNotFound:message = "アカウントが見つかりません"
            case .wrongPassword:message = "パスワードを確認してください"
            case .userDisabled:message = "アカウントが無効です"
            case .invalidEmail:message = "Eメールが無効な形式です"
            default:message = "エラー: \(error.localizedDescription)"
                
            }
            showerrorAlert(title: message, message: message)
        }
    }
    
    //新規登録の時のエラーアラート
    func signInErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:
                message = "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse:
                message = "既に登録されているメールアドレスです"
            case .weakPassword:
                message = "パスワードは６文字以上で入力してください"
            default:
                message = "エラー: \(error.localizedDescription)"
            }
            showerrorAlert(title: message, message: message)
        }
    }
    
    
    
    func presentTabPage() {
        let storyboard = UIStoryboard(name: "TabPage", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func presentNewUser() {
        let storyboard = UIStoryboard(name: "NewUserCreate", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func textFieldShouldReturn( _ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        
    }
    
    
    
    
    
}
