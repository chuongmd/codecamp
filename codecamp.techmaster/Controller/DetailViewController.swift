//
//  DetailViewController.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 8/30/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    @IBOutlet weak var trackNamePlayer: UILabel!
    @IBOutlet weak var artistNamePlayer: UILabel!
    @IBOutlet weak var trackPricePlayer: UILabel!
    @IBOutlet weak var countryPlayer: UILabel!
    @IBOutlet weak var typePlayer: UILabel!
    @IBOutlet weak var artistPreviewImage: UIImageView!
    
    var item: Item?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    
    
    @IBAction func buttonPlay(_ sender: UIButton) {
        
    }

    override func viewDidLoad() {
        
    }
    
    
}
