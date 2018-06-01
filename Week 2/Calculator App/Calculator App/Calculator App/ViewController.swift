//
//  ViewController.swift
//  Calculator App
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

    @IBOutlet weak var X: UITextField!
    @IBOutlet weak var Y: UITextField!
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var History: UILabel!
    
    @IBAction func cal(_ sender: UIButton) {
        var num : Double = 0;
        switch sender.tag {
        case 0:
            num = Double(X.text!)! + Double(Y.text!)!
            Result.text = "Result: \n\(num)"
            History.text = "\(History.text!) \n\(X.text!) + \(Y.text!) = \(num)"
        case 1:
            num = Double(X.text!)! - Double(Y.text!)!
            Result.text = "Result: \n\(num)"
            History.text = "\(History.text!) \n\(X.text!) - \(Y.text!) = \(num)"
        case 2:
            num = Double(X.text!)! * Double(Y.text!)!
            Result.text = "Result: \n\(num)"
            History.text = "\(History.text!) \n\(X.text!) * \(Y.text!) = \(num)"
        case 3:
            num = Double(X.text!)! / Double(Y.text!)!
            Result.text = "Result: \n\(num)"
            History.text = "\(History.text!) \n\(X.text!) / \(Y.text!) = \(num)"
        default:
            print ("error")
        }
        
        
        
    }
    
}

