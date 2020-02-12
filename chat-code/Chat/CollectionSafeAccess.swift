//
//  CollectionSafeAccess.swift
//  chat-code
//
//  Created by kumao on 2020/02/11.
//  Copyright © 2020 kumao. All rights reserved.
//

import Foundation

extension Collection {
    
    //Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

