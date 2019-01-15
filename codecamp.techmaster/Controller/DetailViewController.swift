//
//  DetailViewController.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 8/30/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet weak var trackNamePlayer: UILabel!
    @IBOutlet weak var artistNamePlayer: UILabel!
    @IBOutlet weak var trackPricePlayer: UILabel!
    @IBOutlet weak var countryPlayer: UILabel!
    @IBOutlet weak var typePlayer: UILabel!
    @IBOutlet weak var artistPreviewImage: UIImageView!
    
    var item: Item?
    
    @IBAction func buttonPlay(_ sender: UIButton) {
        guard let navigationVC = storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController else {
            return
        }
        
        guard let playerVC = navigationVC.viewControllers.first as? playerViewController else {
            return
        }
        
        playerVC.item = item
        
        present(navigationVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        if let item = item {
            artistNamePlayer.text = "Artist Name: \(item.artistName)"          
            artistPreviewImage.af_setImage(withURL: item.artworkUrl!)
            trackNamePlayer.text = "Track Name: \(item.trackName)"
            if let price = item.trackPrice {
                trackPricePlayer.text = "Track Price: $\(price)"
            } else {
                trackPricePlayer.text = "N/A"
            }
            
            countryPlayer.text = "Country: \(item.country)"
            typePlayer.text = "Type: \(item.type.description)"
        }
    }
}
