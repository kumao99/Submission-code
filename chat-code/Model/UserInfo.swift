//
//  UserInfo.swift
//  chat-code
//
//  Created by kumao on 2020/02/19.
//  Copyright © 2020 kumao. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserInfo: Codable{
    var id: String
    var name: String = ""
    var kana: String = ""
    var userName: String = ""
    var birth: String = ""
    var address: String = ""
    var createdAt: Timestamp
    var updatedAt: Timestamp
    
    init(id:String){
        self.id = id
        self.createdAt = Timestamp()
        self.updatedAt = Timestamp()
    }
}
