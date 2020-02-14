//
//  Chat.swift
//  chat-code
//
//  Created by kumao on 2020/02/10.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import Firebase


class Chat: TextFieldViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    @IBOutlet weak var keyBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    
    
    private var messages: [Message.Data] = []
    private var messageListener: ListenerRegistration?
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //xibファイルを使ってカスタムセルを使う処理
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        
        self.messageField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNotificationForTextField()
        
        self.messageListener = Firestore.firestore().collection( "chat" ).order( by: "date" ).addSnapshotListener { snapshot, e in
            if let snapshot = snapshot {
                
                self.messages = snapshot.documents.map{ message -> Message.Data in
                    let data = message.data()
                    return Message.Data(senderId: data["sender_id"] as! String,  message: data["text"] as! String)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear( animated )
        if let mUnsubscribe = messageListener { mUnsubscribe.remove() }
    }
    
    
    @IBAction func sendFixBtn(_ sender: Any) {
        sendChatMessage(message: messageField.text ?? "")
    }
    
    //Firestoreにメッセージデータを送る
    private func sendChatMessage(message: String) {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else { return }
        
        let dataStore = Firestore.firestore()
        dataStore.collection("chat").addDocument(data: [
            "text": message,
            "sender_id": id,
            "date": Date()
        ]) { err in
            DispatchQueue.main.async {
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    self.messageField.text = ""
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messages.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ChatTableViewCell",for: indexPath) as! ChatTableViewCell
        if let message = messages[safe: indexPath.row] {
            cell.set(message: message.message)
            
            cell.imageView?.image = UIImage(named: "panda")
        }
        return cell
    }
    
    
//    override func textFieldShouldReturn( _ textField : UITextField) -> Bool {
//        textField.resignFirstResponder()
//    }
    
    
    
    @IBAction func chatPageBtn(_ sender: Any) {
        let vc = Chat.instantiate()
        present(vc, animated: true)
    }
    
    
    @IBAction func settingPageBtn(_ sender: Any) {
        let vc = EditProfile.instantiate()
        present(vc, animated: true)
    }
    
    
    
    
}







