//
//  Chat.swift
//  chat-code
//
//  Created by kumao on 2020/02/10.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit
import Firebase


class Chat: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    private var messages: [Message.Data] = []
    private var messageListener: ListenerRegistration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        
        messageField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    func textFieldShouldReturn( _ textField : UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    
    
}







