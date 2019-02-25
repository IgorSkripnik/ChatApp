//
//  Chat.swift
//  ChatApp
//
//  Created by Igor Skripnik on 11.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit

class Chat {
    var userName:String?
    var text:String?
    var datePost:String?
    
    init(userName:String, text:String, datePost:String) {
        self.userName = userName
        self.text = text
        self.datePost = datePost
    }
}
