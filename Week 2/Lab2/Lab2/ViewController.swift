//
//  ViewController.swift
//  Lab2
//
//  Created by HANSON ZHOU on 13/3/18.
//  Copyright © 2018 HANSON ZHOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBOutlet weak var touchCounter: UILabel!
    var counter : Int = 0
    
    @IBAction func lightOnOff(_ sender: UIButton) {
        //tag property is usually uesd to set a custom attribute of the object
        //It depends on what you want to do
        //here I'm using it as a flag to know which image is loaded
        
        counter += 1
        touchCounter.text = "\(counter) clicks"
        
        if sender.tag == 0 {
            sender.setImage(
                UIImage(named: "lightOn"),
                for: .normal
            )
            sender.tag = 1
        }
        else {
            sender.setImage(
                UIImage(named: "lightOff"),
                for: .normal
            )
            sender.tag = 0
        }
    }
    
}

