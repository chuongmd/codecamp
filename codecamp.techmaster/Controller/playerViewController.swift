//
//  playerViewController.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 9/7/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import UIKit
import AVFoundation

class playerViewController: UIViewController {
    
    var item: Item?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?  
    var timeObserver: Any?
    
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url = item?.previewUrl else {
            return
        }
        
        playerItem = AVPlayerItem(url:url)
        player = AVPlayer(playerItem: playerItem!)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main, using: { [weak self] (time) in
            guard let player = self?.player else {
                return
            }
            if player.currentItem!.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(player.currentTime())
                self?.slider.value = Float(time)
            }
        })
        
        let deviceSize = UIScreen.main.bounds.size
        let playerSize:CGFloat = 300
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.backgroundColor = UIColor.black.cgColor
        playerLayer.frame = CGRect(x: (deviceSize.width - playerSize) / 2 , y: 100, width: playerSize, height: playerSize)
        self.view.layer.addSublayer(playerLayer)
        
        
        slider.minimumValue = 0
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        slider.maximumValue = Float(seconds)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerViewController.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    @objc func finishedPlaying(_ notification:Notification) {
        playButton.setBackgroundImage(UIImage(named: "Play"), for: .normal)
        
        if let stopedPlayerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            stopedPlayerItem.seek(to: kCMTimeZero) { (isFinished) in
                //
            }
        }
        
    }
    
    @IBAction func btnControlPressed(_ sender: UIButton) {
        if player == nil {
            return
        }
        
        if player!.rate > 0 {
            player?.pause()
            sender.setBackgroundImage(UIImage(named: "Play"), for: .normal)
        } else {
            player?.play()
            sender.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
        }
        
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        let seconds : Int64 = Int64(slider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        guard let player = player else {
            return
        }
        player.seek(to: targetTime, completionHandler: {_ in
            
        })
        if player.rate == 0
        {
            player.play()
        }
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        player?.removeTimeObserver(timeObserver!)
        
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
