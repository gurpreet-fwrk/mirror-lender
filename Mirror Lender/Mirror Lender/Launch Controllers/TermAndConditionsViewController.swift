//
//  TermAndConditionsViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/09/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class TermAndConditionsViewController: UIViewController
{
    
    @IBOutlet var consTopBarHght: NSLayoutConstraint!
    @IBOutlet var viewPolicy: UIView!
    @IBOutlet var viewReward: UIView!
    @IBOutlet var scRewards: UISegmentedControl!
    
    override func viewDidLoad()
    {
      let  modelName = UIDevice.modelName
        print(modelName)
        
        if modelName == "Simulator iPhone X"
        {
            consTopBarHght.constant = 88
        }
        else
        {
            consTopBarHght.constant = 64
        }
    }
    
    @IBAction func selectPolicyOrRewards(_ sender: Any)
    {
        switch scRewards.selectedSegmentIndex {
        case 0:
            viewPolicy.isHidden = true
            viewReward.isHidden = false
        case 1:
            viewPolicy.isHidden = false
            viewReward.isHidden = true
        default:
            break;
    }
    }
    
    @IBAction func close(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
