//
//  EditProfile.swift
//  chat-code
//
//  Created by kumao on 2020/02/09.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit

class EditProfile: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let album = UIImagePickerController()
    
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var profileField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var kanaField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var btn: BGButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
//        //ViewControllerのViewの初期設定
//        self.view.backgroundColor = UIColor.white
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        //グラデーションさせるカラーの設定
//        //上から色を濃くしていく
//        let color1 = UIColor(red: 205/255, green:255/255, blue: 255/255, alpha: 0.8).cgColor
//        let color2 = UIColor(red: 0/255, green:200/255, blue: 255/255, alpha: 0.8).cgColor
//        //CAGradientLayerにグラデーションさせるカラーをセット
//        gradientLayer.colors = [color1, color2]
//        //グラデーションの開始地点・終了地点の設定
//        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint.init(x: 0.9, y:0.7)
//        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
//        self.view.layer.insertSublayer(gradientLayer,at:0)
        
        //profile画像
        profileImg.image = UIImage(named: "noimage")
        //TextFieldDelegate設定
        userNameField.delegate = self
        profileField.delegate = self
        nameField.delegate = self
        kanaField.delegate = self
        mailField.delegate = self
        passField.delegate = self
        //ボタン設定
        btn.layer.cornerRadius = 5
        btn.borderWidth = 1
        btn.borderColor = UIColor.orange
        //スマホ内フォトライブラリの利用設定
        album.delegate = self
        
        
    }
    
    
    
    @IBAction func imgBtn(_ sender: Any) {
        //画像の取得方法を設定してカメラから画像を取得する
        let camera = UIImagePickerController.SourceType.savedPhotosAlbum
        
        if UIImagePickerController.isSourceTypeAvailable(camera){
            album.sourceType = camera
            self.present(album, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImg.image = selectedImage  //imageViewにカメラロールから選んだ画像を表示する
        }
        self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
    }
    
    
    func textFieldShouldReturn( _ textField : UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
    }
    
    
    @IBAction func editFixBtn(_ sender: Any) {
        let tabStoryboard: UIStoryboard = UIStoryboard(name: "TabPage", bundle: nil)
        
        //storyboardで画面遷移と値渡し
        let nextVC = tabStoryboard.instantiateViewController(withIdentifier: "tabpage") as! TabPage
        self.present(nextVC, animated: true, completion: {()in
            nextVC.userName.text = self.userNameField.text
            nextVC.icon.image = self.profileImg.image
        })
        
    }
    
    
    
    
    
}
