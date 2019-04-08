//
//  InviteFriendViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import Social

class InviteFriendViewController: UIViewController
{
    override func viewDidLoad()
    {
        self.title = "Invite Friends"
    }
    
    @IBAction func shareWithFriends(_ sender: Any) {
        
        let url = "www.google.com/ABC1234"
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]

        self.present(activityViewController, animated: true, completion: nil)
    }
}
