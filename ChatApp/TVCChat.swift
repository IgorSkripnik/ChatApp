//
//  TVCChat.swift
//  ChatApp
//
//  Created by Igor Skripnik on 11.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit

class TVCChat: UITableViewCell {

    @IBOutlet weak var laUserName: UILabel!
    @IBOutlet weak var laText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChat(chat:Chat) {
        laUserName.text = chat.userName
        laText.text = chat.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
