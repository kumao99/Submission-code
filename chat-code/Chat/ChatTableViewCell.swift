//
//  ChatTableViewCell.swift
//  chat-code
//
//  Created by kumao on 2020/02/11.
//  Copyright © 2020 kumao. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

    }
    func set(message: String?){
        messageLabel.text = message
    }
    
}
