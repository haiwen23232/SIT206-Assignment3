//
//  ViewController.swift
//  Music Player App
//
//  Created by HANSON ZHOU on 27/3/18.
//  Copyright © 2018 HANSON ZHOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var singerImg: UIImageView!
    @IBOutlet weak var nowplayinLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var volumeSlider: UISlider!
    
    //Vars
    var filterBySinger = "All"
    var musicPlayer : MusicPlayer = MusicPlayer( PlayList() )
    var isPlaying: Bool = false
    var timer : Timer!
    var playOrResime : Bool = false
    
    //IBActions
    @IBAction func play(_ sender: UIButton) {
        if playOrResime == true{
            musicPlayer.resume()
        }
        else{
            musicPlayer.play(filterBy: filterBySinger)
        }
        updateUI()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRealtimeUI), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        musicPlayer.pause()
        playOrResime = true
    }
    @IBAction func previous(_ sender: UIButton) {
        musicPlayer.previous(filterBy: filterBySinger)
        updateUI()
    }
    @IBAction func next(_ sender: UIButton) {
        musicPlayer.next(filterBy: filterBySinger)
        updateUI()
    }
    @IBAction func stop(_ sender: UIButton) {
        musicPlayer.stop()
        playOrResime = false
        updateUI()
    }
    @IBAction func changeVolume(_ sender: UISlider) {
        musicPlayer.changeVolume(newValue: sender.value)
    }
    
    //Functions
    @objc func updateRealtimeUI() {
        let curruntSong = musicPlayer.getCurrentSong()
        let progress = Float(curruntSong.timeElapsed / curruntSong.duration)
        songProgress.setProgress(progress, animated: true)
        let elapsedTime = Int(curruntSong.timeElapsed.nextUp)
        let remainingTime = Int(curruntSong.duration.nextUp) - elapsedTime
        elapsedTimeLabel.text = "\(elapsedTime)"
        remainingTimeLabel.text = "\(remainingTime)"
    }
    
    func updateUI(){
        let currentSong = musicPlayer.currentSong
        singerImg.image = UIImage(named : currentSong.singer)
        nowplayinLabel.text = currentSong.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

