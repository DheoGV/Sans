//
//  DeepBreathViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit
import AVFoundation
import AVKit

class DeepBreathViewController: UIViewController {

    @IBOutlet weak var breathContainer: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    let video = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "breathVideo", ofType: "mp4")!))
    var layer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Methods"
        pauseButton.isHidden = true
        playVideo()
    }
    
    func playVideo(){
        layer = AVPlayerLayer(player: video)
        video.automaticallyWaitsToMinimizeStalling = false
        video.seek(to: CMTime.zero)
        layer?.frame = breathContainer.bounds
        breathContainer.layer.addSublayer(layer!)
    }

    @IBAction func pauseAction(_ sender: Any) {
        video.seek(to: CMTime.zero)
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    
    @IBAction func playAction(_ sender: Any) {
        video.play()
        playButton.isHidden = true
        pauseButton.isHidden = false
    }
    
}
