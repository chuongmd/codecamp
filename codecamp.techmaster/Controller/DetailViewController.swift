//
//  DetailViewController.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 8/30/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(item!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
