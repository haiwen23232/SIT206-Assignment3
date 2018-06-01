//
//  ViewController.swift
//  Hanson Zhou
//
//  Created by HANSON ZHOU on 20/3/18.
//  Copyright © 2018 HANSON ZHOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTag()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var imgs : [UIImage] = [
        UIImage(named: "Ball")!,
        UIImage(named: "images-1")!,
        UIImage(named: "images-2")!,
        UIImage(named: "images-3")!,
        UIImage(named: "images-4")!,
        UIImage(named: "images-5")!,
        UIImage(named: "images-6")!,
        UIImage(named: "images-7")!,
        UIImage(named: "images-8")!,
        ]
    
    var lastButton : UIButton?
    // one simple way to set tags if you don't understand the random number
    func setButtonTag(){
        buttons[0].tag = 1
        buttons[1].tag = 2
        buttons[2].tag = 3
        buttons[3].tag = 4
        buttons[4].tag = 1
        buttons[5].tag = 2
        buttons[6].tag = 3
        buttons[7].tag = 4
        buttons[8].tag = 5
        buttons[9].tag = 6
        buttons[10].tag = 7
        buttons[11].tag = 8
        buttons[12].tag = 5
        buttons[13].tag = 6
        buttons[14].tag = 7
        buttons[15].tag = 8
    }
    
    @IBOutlet weak var score: UILabel!
    @IBAction func buttonTouched(_ sender: UIButton) {
        if sender.tag == -1 {return}
        sender.setImage(imgs[sender.tag], for: .normal)
        if lastButton == nil {
            lastButton = sender
        }
        else if lastButton != nil &&
            sender.tag == lastButton!.tag{
            score.text = "\(Int(score.text!)! + 1)"
            sender.tag = -1
            lastButton!.tag = -1
            lastButton = nil
        }
        else{
            sender.setImage(imgs[0], for: .normal)
            lastButton!.setImage(imgs[0], for: .normal)
            lastButton = nil}}
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func reset(_ sender: UIButton) {
        score.text = "0"
        
        //generate an arry of nums with values from zero to munber of buttons
        var nums = Array(0..<buttons.count)
        
        //loop on the arry as long as it still has some numbers to choose from
        while  nums.count > 0 {
            
            var i = Int(arc4random_uniform(UInt32(nums.count)))
            var j = Int(arc4random_uniform(UInt32(nums.count)))
            
            if i != j{
                
                if i > j {
                    i = nums.remove(at: i)
                    j = nums.remove(at: j)
                }
                else{
                    j = nums.remove(at: j)
                    i = nums.remove(at: i)
                }
                let random = Int(arc4random_uniform(UInt32(imgs.count - 1)) + 1)
                
                buttons[i].tag = random
                buttons[j].tag = random
                
                buttons[i].setImage(imgs[0], for: .normal)
                buttons[j].setImage(imgs[0], for: .normal)
            }
        }
    }
    
}

