//
//  VCLoginViewController.swift
//  ChatApp
//
//  Created by Igor Skripnik on 11.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit

class VCLoginViewController: UIViewController {

    @IBOutlet weak var laUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buLogin(_ sender: Any) {
        
        performSegue(withIdentifier: "chatRoom", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chatRoom" {
            
            if let dist = segue.destination as? ViewController {
                dist.UserName = laUserName.text
            }
        }
        
    }

}
