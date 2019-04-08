//
//  HomeGoalThirdViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class HomeGoalThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func moveBack(_ sender: Any)
    {
         NotificationCenter.default.post(name: Notification.Name("changePage"), object: "2")
    }
    
    @IBAction func moveToNextView(_ sender: Any)
    {
        
         NotificationCenter.default.post(name: Notification.Name("changePage"), object: "1")
    }
}
