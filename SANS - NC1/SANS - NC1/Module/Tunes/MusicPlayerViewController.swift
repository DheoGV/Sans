//
//  MusicPlayerViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    public var position: Int = 0
    public var tunes: [Tunes] = []
    
    var player: AVAudioPlayer?
    let playPauseButton = UIButton()
    
    private let musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let tunesNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let tunesMakerLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    
    func configure(){
        let tune = tunes[position]
        
        guard let urlString = Bundle.main.path(forResource: tune.tunesName, ofType: "mp3") else { return }
        
        let music = NSURL(fileURLWithPath: urlString)
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            player = try AVAudioPlayer(contentsOf: music as URL)
            
            guard let player = player else{
                return
            }
            
            //player.volume = 0.5
            player.play()
        }
        catch{
            print("error occured")
        }
        
        //Setup UI
        //Image
        musicImageView.frame = CGRect(x: 50, y: 50, width: holder.frame.size.width-100, height: holder.frame.size.width-100)
        musicImageView.image = UIImage(named: tune.img)
        holder.addSubview(musicImageView)
        
        //label
        tunesNameLbl.frame = CGRect(x: 10, y: musicImageView.frame.size.height + 50, width: holder.frame.size.width-20, height: 70)
        tunesMakerLbl.frame = CGRect(x: 10, y: musicImageView.frame.size.height + 50 + 30, width: holder.frame.size.width-20, height: 70)

        tunesNameLbl.text = tune.name
        tunesMakerLbl.text = tune.tunesMaker

        holder.addSubview(tunesNameLbl)
        holder.addSubview(tunesMakerLbl)
        
        //slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlide(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
        //player control
        let nextButton = UIButton()
        let backButton = UIButton()
        
        let yPosition = tunesMakerLbl.frame.origin.y + 70 + 70
        let  size: CGFloat = 50
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 60, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 60, y: yPosition, width: size, height: size)

        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        playPauseButton.tintColor = UIColor.primaryColor
        nextButton.tintColor = UIColor.primaryColor
        backButton.tintColor = UIColor.primaryColor
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
    @objc func didSlide(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    
    @objc func didTapPlayPauseButton(){
        if player?.isPlaying == true {
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //img Animation
            UIView.animate(withDuration: 0.2, animations: {
                self.musicImageView.frame = CGRect(x: 70, y: 70, width: self.holder.frame.size.width-140, height: self.holder.frame.size.width-140)

            })
        }else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //img Animation
            UIView.animate(withDuration: 0.2, animations: {
                self.musicImageView.frame = CGRect(x: 50, y: 50, width: self.holder.frame.size.width-100, height: self.holder.frame.size.width-100)

            })
        }
    }
    
    @objc func didTapNextButton(){
        if position < (tunes.count - 1) {
            position += 1
            player?.stop()
            for subView in holder.subviews{
                subView.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position -= 1
            player?.stop()
            for subView in holder.subviews{
                subView.removeFromSuperview()
            }
            configure()
        }
    }
}
