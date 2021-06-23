//
//  CountDownViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit

class CountDownViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var countDownLbl: UILabel!
    
    var timeRemaining: Int = 100
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Methods"
        pauseButton.isHidden = true
    }
    
    
    @IBAction func playAction(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        playButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        timer.invalidate()
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    
    @IBAction func resetAction(_ sender: Any) {
        timer.invalidate()
        timeRemaining = 100
        countDownLbl.text = "\(timeRemaining)"
    }
    
    @objc func step (){
        if timeRemaining > 0{
            timeRemaining -= 1
        }else{
            timer.invalidate()
            timeRemaining = 100
        }
        countDownLbl.text = "\(timeRemaining)"
    }
    
}
