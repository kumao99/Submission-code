//
//  FirestoreData.swift
//  chat-code
//
//  Created by kumao on 2020/02/11.
//  Copyright © 2020 kumao. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

 let db = Firestore.firestore()

private func addUser() {
    // [START add_ada_lovelace]
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    ref = db.collection("users").addDocument(data: [
        "first": "Ada",
        "last": "Lovelace",
        "born": 1815
    ]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
        }
    }
    
//    ref = db.collection("users").addDocument(data: [
//        "first": "Alan",
//        "middle": "Mathison",
//        "last": "Turing",
//        "born": 1912
//    ]) { err in
//        if let err = err {
//            print("Error adding document: \(err)")
//        } else {
//            print("Document added with ID: \(ref!.documentID)")
//        }
//    }

    
    
}





