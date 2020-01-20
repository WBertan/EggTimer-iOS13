//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleView: UILabel!
    
    private var timerProgress: Timer?
    private var player: AVAudioPlayer!
    
    private let hardnessTime = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardnessSelected = sender.currentTitle else { return }
        guard let time = hardnessTime[hardnessSelected] else { return }
        
        titleView.text = hardnessSelected
        setTimer(timeInSeconds: time)
    }
    
    private func setTimer(timeInSeconds: Int) {
        timerProgress?.invalidate()
        player?.stop()
        
        progressView.isHidden = false
        progressView.progress = 0
        
        let step = 1.0 / Float(timeInSeconds)
        
        timerProgress = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            let progress = self.progressView.progress + step
            self.progressView.setProgress(progress, animated: true)
            if(progress >= 1) {
                timer.invalidate()
                self.playSound()
                self.titleView.text = "Done!"
                self.progressView.isHidden = true
            }
        })
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
