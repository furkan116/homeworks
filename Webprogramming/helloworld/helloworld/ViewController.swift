//
//  ViewController.swift
//  helloworld
//
//  Created by Furkan Yıldırım on 28.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: Any) {
        label.text = "Hello World!"
    }
    
}

